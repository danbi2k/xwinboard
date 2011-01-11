using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace ConsoleApplication1
{
    class Program
    {
        static string LOGIN_URL = "http://www.show.co.kr/common/user/cp_sub_login_frame.asp?RETURN_URL=http%3A%2F%2Fwww%2Eshow%2Eco%2Ekr%2Findex%2Easp%3Fcode%3DFB00000";
        static String DB_STR = "server=localhost;database=danmuji;user=kimchi;password=gjfEjr^RjfEjr;port=33406";
        static char[] SEPERATOR = { ' ', '|' };
        static WebBrowser webBrowser1;
        static MySqlConnection conn;
        static DateTime heart;
        static Timer time;

        [STAThread]
        static void Main(string[] args)
        {
            Console.WriteLine("Main을 시작하자");
            System.Threading.Thread t = new System.Threading.Thread(ThreadStart);
            t.SetApartmentState(System.Threading.ApartmentState.STA);

            t.Start();
            heart = DateTime.Now;

            while (true) {
                Console.WriteLine("심장박동이 오는지 보자");
                DateTime now = DateTime.Now;
                if (heart.AddMinutes(2.0) < now)
                {
                    Console.WriteLine("심장박동이 2분넘게 안온다");
                    if (t != null)
                    {
                        conn.Close();
                        Console.WriteLine("DB Close");
                        t.Abort();
                        Console.WriteLine("쓰레드 종료");
                    }

                    t = new System.Threading.Thread(ThreadStart);
                    t.SetApartmentState(System.Threading.ApartmentState.STA);

                    t.Start();
                    Console.WriteLine("새 쓰레드 시작 시도");
                }
                else
                {
                    Console.WriteLine("심장박동이 잘 온다");
                }
                System.Threading.Thread.Sleep(120000);
            }
        }

        public static void ThreadStart()
        {
            Console.WriteLine("새 쓰레드 시작");
            conn = new MySqlConnection();
            conn.ConnectionString = DB_STR;
            conn.Open();

            Console.WriteLine("DB Open");

            webBrowser1 = new WebBrowser(); 
            webBrowser1.Dock = DockStyle.Fill;
            webBrowser1.Name = "webBrowser";
            webBrowser1.ScrollBarsEnabled = false;
            webBrowser1.TabIndex = 0;
            webBrowser1.ScriptErrorsSuppressed = true;
            webBrowser1.Url = new Uri(LOGIN_URL);

            webBrowser1.DocumentCompleted += new WebBrowserDocumentCompletedEventHandler(browser_DocumentCompleted);

            Form form = new Form();
            form.WindowState = FormWindowState.Minimized;
            form.Controls.Add(webBrowser1);
            form.Name = "Browser";

            Application.Run(form);

            Console.WriteLine("APP RUN");
        }

        private static void browser_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            Console.WriteLine(e.Url.AbsoluteUri);
            HtmlWindow hw = webBrowser1.Document.Window;

            try
            {

                if (e.Url.AbsoluteUri == "http://www.show.co.kr/common/user/cp_sub_login_frame.asp?RETURN_URL=http://www.show.co.kr/index.asp?code=FB00000")
                {
                    Console.WriteLine("로그인 시작");
                    HtmlElement ID = hw.Document.GetElementById("ID");
                    HtmlElement PASSWORD = hw.Document.GetElementById("PASSWORD");

                    ID.InnerText = "rlska9";
                    PASSWORD.InnerText = "tmakxm2";

                    HtmlElement loginForm = hw.Document.Forms[0];
                    loginForm.InvokeMember("submit");
                    Console.WriteLine("로그인 시도");
                }

                if (e.Url.AbsoluteUri == "http://www.show.co.kr/index.asp?code=FB00000")
                {
                    Console.WriteLine("로그인 성공");
                    time = new Timer();
                    time.Interval = 20000;
                    time.Tick += new EventHandler(Time_Tick);
                    time.Start();
                    Console.WriteLine("타이머 시작");
                }

                if (e.Url.AbsoluteUri == "http://msgmgr.show.co.kr/msgportal/msgmgrTwo/msgBox/receiveList.asp")
                {
                    Console.WriteLine("받은문자함 열림");

                    HtmlElement message_list = hw.Document.GetElementById("message_list");
                    HtmlElementCollection tr = message_list.Children[0].Children[0].Children;
                    int count = 0;
                    for (int i = 1; i < tr.Count; i++)
                    {
                        if (tr[i].Children.Count <= 1)
                            continue;

                        string[] peace = tr[i].Children[1].InnerHtml.Split(SEPERATOR);
                        string msg_seq = peace[4];
                        string in_date = peace[6];

                        string call_back = tr[i].Children[4].InnerText;
                        string msg = tr[i].Children[5].GetElementsByTagName("TEXTAREA")[0].InnerText;

                        //Console.WriteLine(msg_seq + " " + in_date + " " + call_back + " " + msg);

                        string query = String.Format("INSERT INTO tbl_showsms (MSG_SEQ, IN_DATE, MSG, SM, CALL_BACK) VALUES('{0}', '{1}', '{2}', '{3}', '{4}');",
                            msg_seq, in_date, msg, "S", call_back);

                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.ExecuteNonQuery();

                        count++;
                    }

                    if (count > 0)
                        hw.Navigate(new Uri("http://msgmgr.show.co.kr/msgportal/msgmgrTwo/msgBox/MsgDelete.asp?msg_seq=&in_date=&lock_i=&sm=&cid=&msgboxCd=&boxType=1"));

                    Console.WriteLine("받은 문자 갯수 : " + count);
                    heart = DateTime.Now;
                }
            } catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);

                time.Stop();
                Console.WriteLine("타이머 스탑");
                conn.Close();
                Console.WriteLine("DB Close");
            }
        }

        private static void Time_Tick(object obj, EventArgs e)
        {
            HtmlWindow hw = webBrowser1.Document.Window;
            hw.Navigate("http://msgmgr.show.co.kr/msgportal/msgmgrTwo/msgBox/receiveList.asp");
            Console.WriteLine("받은문자함 열기");
        }
    }
}

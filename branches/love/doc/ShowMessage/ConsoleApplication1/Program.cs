using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Web;
using System.Net;
using MySql.Data.MySqlClient;

namespace ConsoleApplication1
{
    class Program
    {
        //static String SERVER_URL = "http://localhost:8080/love/protocol.php?mode=autoChargeAlive";
        static String SERVER_URL = "http://localhost/protocol.php?mode=autoChargeAlive";

        static string LOGIN_URL = "http://mms.mobile.olleh.com/msgportal2/msgmgr/msgmgrInfo.asp";
        static String DB_STR = "server=localhost;database=danmuji;user=kimchi;password=gjfEjr^RjfEjr;port=33406";
        static char[] SEPERATOR = { ' ', '|' };
        static WebBrowser webBrowser1;
        static MySqlConnection conn;
        static DateTime heart;
        static Timer time;

        static String userId = "rlska9";
        static String password = "tmakxm2";

        [STAThread]
        static void Main(string[] args)
        {
            Console.WriteLine("Main을 시작하자");
            System.Threading.Thread t = new System.Threading.Thread(ThreadStart);
            t.SetApartmentState(System.Threading.ApartmentState.STA);

            t.Start();
            heart = DateTime.Now;

            if (args.Length > 1)
            {
                userId = args[0];
                password = args[1];
            }

            Console.WriteLine("{0}, {1}", userId, password);

            while (true)
            {
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
                    HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(SERVER_URL);
                    myReq.GetResponse();
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

                if (e.Url.AbsoluteUri == "http://mms.mobile.olleh.com/msgportal2/msgmgr/msgmgrInfo.asp")
                {
                    Console.WriteLine("로그인 시작");
                    HtmlElement ID = hw.Document.GetElementById("ID");
                    HtmlElement PASSWORD = hw.Document.GetElementById("PASSWORD");
                    HtmlElement loginBtn = hw.Document.GetElementById("loginBtn");

                    ID.InnerText = userId;
                    PASSWORD.InnerText = password;
                    loginBtn.InvokeMember("OnClick");
                    
                    Console.WriteLine("로그인 시도");
                }

                if (e.Url.AbsoluteUri == "http://mobile.olleh.com/index.asp?code=FBA0000&urljump=http%3A%2F%2Fmms%2Emobile%2Eolleh%2Ecom%2Fmsgportal2%2Fmsgmgr%2FmsgmgrInfo%2Easp")
                {
                    Console.WriteLine("로그인 성공");
                    time = new Timer();
                    time.Interval = 20000;
                    time.Tick += new EventHandler(Time_Tick);
                    time.Start();
                    Console.WriteLine("타이머 시작");
                }

                if (e.Url.AbsoluteUri == "http://mms.mobile.olleh.com/msgportal2/MsgMgr/msgBox/receiveList.asp")
                {
                    Console.WriteLine("받은문자함 열림");

                    HtmlElement message_list = hw.Document.GetElementById("message_list");
                    HtmlElementCollection tr = message_list.Children[0].Children[2].Children;
                    int count = 0;
                    for (int i = 0; i < tr.Count; i++)
                    {
                        if (tr[i].Children.Count <= 1)
                            continue;

                        string[] peace = tr[i].Children[0].InnerHtml.Split(SEPERATOR);
                        string msg_seq = peace[5];
                        string in_date = peace[7];

                        string call_back = tr[i].Children[3].InnerText;
                        string msg = tr[i].Children[4].GetElementsByTagName("TEXTAREA")[0].InnerText;

                        //Console.WriteLine(msg_seq + " " + in_date + " " + call_back + " " + msg);

                        string query = String.Format("INSERT INTO tbl_showsms (MSG_SEQ, IN_DATE, MSG, SM, CALL_BACK) VALUES('{0}', '{1}', '{2}', '{3}', '{4}');",
                            msg_seq, in_date, msg, "S", call_back);

                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.ExecuteNonQuery();

                        count++;
                    }

                    if (count > 0)
                        hw.Navigate(new Uri("http://mms.mobile.olleh.com/msgportal2/MsgMgr/msgBox/MsgDelete.asp?boxType=1"));

                    Console.WriteLine("받은 문자 갯수 : " + count);
                    heart = DateTime.Now;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Console.WriteLine(ex.StackTrace);

                if (time != null)
                {
                    time.Stop();
                    Console.WriteLine("타이머 스탑");
                }
                conn.Close();
                Console.WriteLine("DB Close");
            }
        }

        private static void Time_Tick(object obj, EventArgs e)
        {
            HtmlWindow hw = webBrowser1.Document.Window;
            hw.Navigate("http://mms.mobile.olleh.com/msgportal2/MsgMgr/msgBox/receiveList.asp");
            Console.WriteLine("받은문자함 열기");
        }
    }
}

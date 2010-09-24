using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Security.Cryptography;

namespace Keygen
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var encoding = new ASCIIEncoding();
            var source = encoding.GetBytes(textBox1.Text);
            SHA256 shaM = new SHA256Managed();
            var hash = shaM.ComputeHash(source);
            var base64 = System.Convert.ToBase64String(hash);
            textBox2.Text = base64.Substring(6, 5).ToLower();
        }
    }
}

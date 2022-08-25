using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

//3xploit666
// 25/08/2022
// https://github.com/3xploit666
namespace PeToBitConver
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {

            var contet = richTextBox1.Text.Length;
            if (contet > 0)
            {
                Clipboard.SetText(richTextBox1.Text);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            OpenFileDialog open = new OpenFileDialog();
            open.Filter = "App|*.exe|dll|*.dll|bin|*.bin";
            if (open.ShowDialog() == DialogResult.OK)
            {
            }
            textBox1.Text = open.FileName;

            var cont = BitConverter.ToString(System.IO.File.ReadAllBytes(textBox1.Text)).Replace("-", "");
            richTextBox1.Text = cont;

        }
    }
}

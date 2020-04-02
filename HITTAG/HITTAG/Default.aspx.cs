using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HITTAG
{
    public partial class _Default : Page
    {


       public string GetIPAddress()
        {
            string IPAddress = "";
            IPHostEntry Host = default(IPHostEntry);
            string Hostname = null;
            Hostname = System.Environment.MachineName;
            Host = Dns.GetHostEntry(Hostname);
            foreach (IPAddress IP in Host.AddressList)
            {
                if (IP.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                {
                    IPAddress = Convert.ToString(IP);
                }
            }
            return IPAddress;
        }


        
        [WebMethod]
        public static string GetData()
        {

            return "This string is from Code behind";


        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lb_YourIP.Text = "Your Client IP Address : " + GetIPAddress();
        }

        protected void btn_Check_Click(object sender, EventArgs e)
        {
            lb_Status.Text = "";
            string ip = txtIP.Text.Trim();
            if (ip != "")
            {

                Ping ping = new Ping();
                PingReply pingresult = ping.Send(ip);
                if (pingresult.Status.ToString() == "Success")
                {
                    lb_Status.Text = "[" + ip + "] Status : " + pingresult.Status.ToString();
                }
                else
                {
                    lb_Status.Text = "[" + ip + "] Status > : " + pingresult.Status.ToString();
                }

            }
        }
        protected void btn_Check_List_Click(object sender, EventArgs e)
        {
            lb_Status.Text = "";
            string[] List_IP = { "192.168.1.3", "192.168.1.4", "192.168.1.5", "192.168.1.6", "192.168.1.7", "192.168.1.25" };
            foreach (string iplist in List_IP)
            {

                if (iplist != "")
                {
                    Ping ping = new Ping();
                    PingReply pingresult = ping.Send(iplist);
                    lb_Status.Text += "[" + iplist + "] Status : " + pingresult.Status.ToString() + "<br>";

                }

            }
        }






    }





    }
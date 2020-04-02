<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HITTAG._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.blockUI/2.66.0-2013.10.09/jquery.blockUI.js"> </script>

    <script>

        function DisplayIP(response) {
            $("#ipaddress").html(response.ip)
        }

        $(document).ready(function () {

            var script = document.createElement("script");
            script.type = "text/javascript";
            script.src = "https://api.ipify.org?format=jsonp&callback=DisplayIP";
            document.getElementsByTagName("head")[0].appendChild(script);

            $("#btn_Check").click(function () {
                var IP = $("#txtIP").val();
                fp = new http_ping(IP);




            });



            $("#btn_Test").click(function () {


                 $.blockUI({ message: '<img src="resources/images/loadingajax.gif" /> Loading...' });

                alert('test');
                    
                var dataValue = { "ip": "192.168.1.3" };





                $.ajax({
                    url: "Default/GetData",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Error Request: " + XMLHttpRequest.toString() + "\nStatus: " + textStatus + "\nError: " + errorThrown);
                    },
                    success: function (data) {
                        $('#responseContent').text(data.d);
                    }

                });


                //$.ajax({
                //    type: "POST",
                //    url: "Default/GetData",
                //    contentType: 'application/json; charset=utf-8',
                //    dataType: 'json',
                //    error: function (XMLHttpRequest, textStatus, errorThrown) {
                //        alert("Error Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                //    },
                //    success: function (result) {
                //        alert("We returned: " + result);
                //    }
                //});


                alert('test12341234');
                $.unblockUI();

            });




          });


        function http_ping(fqdn) {

            var NB_ITERATIONS = 4; // number of loop iterations
            var MAX_ITERATIONS = 5; // beware: the number of simultaneous XMLHttpRequest is limited by the browser!
            var TIME_PERIOD = 1000; // 1000 ms between each ping
            var i = 0;
            var over_flag = 0;
            var time_cumul = 0;
            var REQUEST_TIMEOUT = 9000;
            var TIMEOUT_ERROR = 0;

            document.getElementById('result').innerHTML = "HTTP ping for " + fqdn + "</br>";

            var ping_loop = setInterval(function () {

                url = "http://" + fqdn + "/a30Fkezt_77" + Math.random().toString(36).substring(7);
                if (i < MAX_ITERATIONS) {
                    var ping = new XMLHttpRequest();
                    i++;
                    ping.seq = i;
                    over_flag++;
                    ping.date1 = Date.now();
                    ping.timeout = REQUEST_TIMEOUT; // it could happen that the request takes a very long time
                    ping.onreadystatechange = function () { // the request has returned something, let's log it (starting after the first one)
                        if (ping.readyState == 4 && TIMEOUT_ERROR == 0) {

                            over_flag--;

                            if (ping.seq > 1) {
                                delta_time = Date.now() - ping.date1;
                                time_cumul += delta_time;
                                document.getElementById('result').innerHTML += "</br>Reply from  " + fqdn + ":" + (ping.seq - 1) + " time=" + delta_time + " ms</br>";
                            }
                        }
                    }
                    ping.ontimeout = function () {
                        TIMEOUT_ERROR = 1;
                    }
                    ping.open("GET", url, true);
                    ping.send();
                }
                if ((i > NB_ITERATIONS) && (over_flag < 1)) { // all requests are passed and have returned
                    clearInterval(ping_loop);
                    var avg_time = Math.round(time_cumul / (i - 1));
                    document.getElementById('result').innerHTML += "</br> Average ping latency on " + (i - 1) + " iterations: " + avg_time + "ms </br>";
                }
                if (TIMEOUT_ERROR == 1) { // timeout: data cannot be accurate
                    clearInterval(ping_loop);
                    document.getElementById('result').innerHTML += "<br/> THERE WAS A TIMEOUT ERROR <br/>";
                    return;
                }

            }, TIME_PERIOD);
        }

    </script>



    <div class="jumbotron">
        <h1>HITTAG</h1>
        <p class="lead" style="display: inline;">Example ping IP status. Your IP Address is : <span id="ipaddress"></span></p>
        <br />
        <asp:Label ID="lb_YourIP" runat="server" Text="Label"></asp:Label>

        <div class="form-horizontal">
            <div class="form-group">


                <label class="col-sm-12 col-xs-12" style="display: inline;">IP :</label>



                <asp:TextBox ID="txtIP" runat="server" CssClass="form-control" Style="display: inline; width: 50%;"></asp:TextBox>
                <asp:Button ID="btn_Check" runat="server" Text="Check" class="btn btn-primary" Style="display: inline; width: 10%;" OnClick="btn_Check_Click" />&nbsp;&nbsp;
                <asp:Button ID="btn_Check_List" runat="server" Text="Check List" class="btn btn-primary" Style="display: inline; width: 10%;" OnClick="btn_Check_List_Click" />
                <br />
                
                <button id="btn_Test" class="btn btn-primary" >testxt</button>




                <asp:Label ID="lb_Status" runat="server" Text=""></asp:Label>
            </div>

        </div>


        <div id="result"></div>

    </div>



</asp:Content>

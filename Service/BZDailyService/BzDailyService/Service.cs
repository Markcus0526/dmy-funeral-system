using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.IO;
using System.Threading;
using System.Configuration;
using System.Net;

namespace BzDailyService
{
    public partial class Service : ServiceBase
    {
        public String strServerAddress = "http://192.168.1.18:10241/Service.svc/";

        public Service()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            this.WriteToFile("BzDailyService started {0}");
            this.ScheduleSvcPerformanceReport();
            this.ScheduleSvcBirthdayRemind();

            string mode = ConfigurationManager.AppSettings["Mode"].ToUpper();
            this.WriteToFile("BzDailyService Mode: " + mode + " {0}");
        }

        protected override void OnStop()
        {
            this.WriteToFile("BzDailyService stopped {0}");
            this.Schedular.Dispose();
        }

        private Timer Schedular;

        public void ScheduleSvcPerformanceReport()
        {
            try
            {
                Schedular = new Timer(new TimerCallback(SchedularCallbackPerformanceReport));

                string mode = ConfigurationManager.AppSettings["Mode"].ToUpper();

                //Set the Default Time.
                DateTime schTime = DateTime.MinValue;

                if (mode == "DAILY")
                {
                    //Get the Scheduled Time from AppSettings.
                    schTime = DateTime.Parse(System.Configuration.ConfigurationManager.AppSettings["DailyReportScheduledTime"]);
                    schTime = DateTime.Today.AddHours(schTime.Hour).AddMinutes(schTime.Minute);
                    if (DateTime.Now > schTime)
                    {
                        callServiceDailyReport();
                    }
                }
                else if (mode.ToUpper() == "INTERVAL")
                {
                    int intervalMinutes = Convert.ToInt32(ConfigurationManager.AppSettings["IntervalMinutes"]);
                    schTime = DateTime.Now.AddMinutes(intervalMinutes);
                    callServiceDailyReport();                    
                }

                TimeSpan timeSpan = schTime.Subtract(DateTime.Now);
                string schedule = string.Format("{0} day(s) {1} hour(s) {2} minute(s) {3} seconds(s)", timeSpan.Days, timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds);

                //Get the difference in Minutes between the Scheduled and Current Time.
                int dueTime = Convert.ToInt32(timeSpan.TotalMilliseconds);

                //Change the Timer's Due Time.
                Schedular.Change(dueTime, Timeout.Infinite);
            }
            catch (Exception ex)
            {
                WriteToFile("Error on: {0} " + ex.Message + ex.StackTrace);

                //Stop the Windows Service.
                using (System.ServiceProcess.ServiceController serviceController = new System.ServiceProcess.ServiceController("BzDailyService"))
                {
                    serviceController.Stop();
                }
            }
        }

        public void ScheduleSvcBirthdayRemind()
        {
            try
            {
                Schedular = new Timer(new TimerCallback(SchedularCallbackPerformanceReport));

                string mode = ConfigurationManager.AppSettings["Mode"].ToUpper();

                //Set the Default Time.
                DateTime schTime = DateTime.MinValue;

                if (mode == "DAILY")
                {
                    //Get the Scheduled Time from AppSettings.
                    schTime = DateTime.Parse(System.Configuration.ConfigurationManager.AppSettings["BirthdayRemindScheduledTime"]);
                    schTime = DateTime.Today.AddHours(schTime.Hour).AddMinutes(schTime.Minute);
                    if (DateTime.Now > schTime)
                    {
                        callServiceBirthdayRemind();
                    }
                }
                else if (mode.ToUpper() == "INTERVAL")
                {
                    int intervalMinutes = Convert.ToInt32(ConfigurationManager.AppSettings["IntervalMinutes"]);
                    schTime = DateTime.Now.AddMinutes(intervalMinutes);
                    callServiceBirthdayRemind();
                }

                TimeSpan timeSpan = schTime.Subtract(DateTime.Now);
                string schedule = string.Format("{0} day(s) {1} hour(s) {2} minute(s) {3} seconds(s)", timeSpan.Days, timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds);

                //Get the difference in Minutes between the Scheduled and Current Time.
                int dueTime = Convert.ToInt32(timeSpan.TotalMilliseconds);

                //Change the Timer's Due Time.
                Schedular.Change(dueTime, Timeout.Infinite);
            }
            catch (Exception ex)
            {
                WriteToFile("Error on: {0} " + ex.Message + ex.StackTrace);

                //Stop the Windows Service.
                using (System.ServiceProcess.ServiceController serviceController = new System.ServiceProcess.ServiceController("BzDailyService"))
                {
                    serviceController.Stop();
                }
            }
        }

        private void SchedularCallbackPerformanceReport(object e)
        {
            this.ScheduleSvcPerformanceReport();
        }

        private void SchedularCallbackBirthdayRemind(object e)
        {
            this.ScheduleSvcBirthdayRemind();
        }

        private void WriteToFile(string text)
        {
            string path = "C:\\BzDailyServiceLog.txt";
            using (StreamWriter writer = new StreamWriter(path, true))
            {
                writer.WriteLine(string.Format(text, DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt")));
                writer.Close();
            }
        }

        private void callServiceDailyReport()
        {
            try
            {
                String serviceUrl = strServerAddress + "dailyPerformanceReport";
                WebRequest request = WebRequest.Create(serviceUrl);
                request.Method = "GET";
                request.GetResponse();
                this.WriteToFile("BzDailyService callServiceDailyReport called successfully!");
            }
            catch (System.Exception ex)
            {
                WriteToFile("BzDailyService Error on: {0} " + ex.Message + ex.StackTrace);
            }            
        }

        private void callServiceBirthdayRemind()
        {
            try
            {
                String serviceUrl = strServerAddress + "clientParentBirthdayRemind";
                WebRequest request = WebRequest.Create(serviceUrl);
                request.Method = "GET";
                request.GetResponse();
                this.WriteToFile("BzDailyService callServiceBirthdayRemind called successfully!");
            }
            catch (System.Exception ex)
            {
                WriteToFile("BzDailyService Error on: {0} " + ex.Message + ex.StackTrace);                
            }
            
        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using NAudio.Wave;
using NAudio.Wave.SampleProviders;
using NAudio.CoreAudioApi;

namespace WindowsFormsApplication2
{
    public partial class Form1 : Form
    {
        public WaveIn waveInObj;
        public BufferedWaveProvider bufWaveProv;
        public MeteringSampleProvider metSampleProv;
        public SampleChannel sampleChan;

        public Form1()
        {
            InitializeComponent();
            MMDeviceEnumerator enume = new MMDeviceEnumerator();
            var devices = enume.EnumerateAudioEndPoints(DataFlow.All, DeviceState.Active);
            comboBox1.Items.AddRange(devices.ToArray());
        }

        private void bStartClick(object sender, EventArgs e)
        {
            waveInObj = new WaveIn();
            
            waveInObj.DeviceNumber = 0;
            waveInObj.DataAvailable += WaveInObj_DataAvailable;

            bufWaveProv = new BufferedWaveProvider(waveInObj.WaveFormat);
            bufWaveProv.DiscardOnBufferOverflow = true;            

            sampleChan = new SampleChannel(bufWaveProv);
            //sampleChan.PreVolumeMeter += SampleChan_PreVolumeMeter;

            metSampleProv = new MeteringSampleProvider(sampleChan);
            metSampleProv.StreamVolume += MetSampleProv_StreamVolume;
            
            waveInObj.StartRecording();
        }

        private void MetSampleProv_StreamVolume(object sender, StreamVolumeEventArgs e)
        {
            label1.Text = e.MaxSampleValues[0].ToString();
        }

        private void SampleChan_PreVolumeMeter(object sender, StreamVolumeEventArgs e)
        {
            label1.Text = e.MaxSampleValues[0].ToString();
            
        }

        private void WaveInObj_DataAvailable(object sender, WaveInEventArgs e)
        {
            bufWaveProv.AddSamples(e.Buffer, 0, e.BytesRecorded);           
            
        }

        private void bStop_Click(object sender, EventArgs e)
        {
            waveInObj.StopRecording();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            //
            if (comboBox1.SelectedItem != null)
            {
                var device = (MMDevice)comboBox1.SelectedItem;
                
                float rawValue = device.AudioMeterInformation.MasterPeakValue*100;
                double dbValue = (20 * Math.Log10(rawValue));
                //progressBar1.Value = dbValue;
                //label1.Text = progressBar1.Value.ToString();
                label1.Text = dbValue.ToString();
                //             progressBar1.Value = (int)(Math.Round(device.AudioMeterInformation.PeakValues[0] * 100));
                
            }
        }
    }
}

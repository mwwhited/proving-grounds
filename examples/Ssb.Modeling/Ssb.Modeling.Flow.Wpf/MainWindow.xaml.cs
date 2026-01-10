using Ssb.Modeling.Flow.Wpf.DragReorder;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Ssb.Modeling.Flow.Wpf
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private int _serviceCounter = 0;
        private int _messageCounter = 0;
        public MainWindow()
        {
            InitializeComponent();

            this.Services = new ObservableCollection<ServiceModel>();
            this.Messages = new ObservableCollection<MessageModel>();
            this.MessageTypes = new ObservableCollection<MessageTypeModel>();

            this._drawingSurface.Messages = this.Messages;

            this.Loaded += MainWindow_Loaded;

            this.DataContext = new
            {
                this.Services,
                this.Messages,
                this.MessageTypes,
            };
        }

        void MainWindow_Loaded(object sender, RoutedEventArgs e)
        {
            this.dragMgr = new ListViewDragDropManager<MessageModel>(this._messages, .7d);
            this.dragMgr.ProcessDrop += dragMgr_ProcessDrop;
            this.dragMgr2 = new ListViewDragDropManager<ServiceModel>(this._services, .7d);
            this.dragMgr2.ProcessDrop += dragMgr_ProcessDrop;
            this.dragMgr3 = new ListViewDragDropManager<MessageTypeModel>(this._messageTypes, .7d);
            this.dragMgr3.ProcessDrop += dragMgr_ProcessDrop;
            this._messages.Drop += OnListViewDrop;
        }

        private ListViewDragDropManager<MessageModel> dragMgr;
        private ListViewDragDropManager<ServiceModel> dragMgr2;
        private ListViewDragDropManager<MessageTypeModel> dragMgr3;
        public ObservableCollection<ServiceModel> Services { get; set; }
        public ObservableCollection<MessageModel> Messages { get; set; }
        public ObservableCollection<MessageTypeModel> MessageTypes { get; set; }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Services.Add(new ServiceModel
            {
                Name = string.IsNullOrWhiteSpace(this._serviceName.Text) ? string.Format("Srv{0}", this._serviceCounter++, new string('_', this._serviceCounter / 2)) : this._serviceName.Text,
            });
        }

        private void Button_Click_1(object s, RoutedEventArgs e)
        {
            var name = string.IsNullOrWhiteSpace(this._messageName.Text) ? string.Format("Msg{0}", this._messageCounter++, new string('_', this._messageCounter / 2)) : this._messageName.Text;
            this.Messages.Add(new MessageModel
            {
                Sender = this._sender.SelectedValue as string,
                Receiver = this._receiver.SelectedValue as string,
                Name = name,
            });

            if (!this.MessageTypes.Any(m => m.Name == name))
            {
                this.MessageTypes.Add(new MessageTypeModel
                {
                     Name = name,
                });
            }
        }
        // Handles the Drop event for both ListViews.
        private void OnListViewDrop(object sender, DragEventArgs e)
        {
            if (e.Effects == DragDropEffects.None)
                return;

            //Task task = e.Data.GetData(typeof(object)) as Task;
            if (sender == this._messages)
            {
                if (this.dragMgr.IsDragInProgress)
                    return;
            }
        }
        // Performs custom drop logic for the top ListView.
        void dragMgr_ProcessDrop<T>(object sender, ProcessDropEventArgs<T> e) where T : class
        {
            // This shows how to customize the behavior of a drop.
            // Here we perform a swap, instead of just moving the dropped item.

            e.ItemsSource.Move(e.OldIndex, e.NewIndex);

            // Set this to 'Move' so that the OnListViewDrop knows to 
            // remove the item from the other ListView.
            e.Effects = DragDropEffects.Move;
        }

        private void ComboBox_LostFocus(object sender, RoutedEventArgs e)
        {
            var combobox = sender as ComboBox;
            if (combobox == null)
                return;

            var itemText = combobox.Text;
            if (string.IsNullOrWhiteSpace(itemText) ||
                this.Services.Any(s => s.Name == itemText))
                return;

            this.Services.Add(new ServiceModel
            {
                Name = itemText,
            });
        }
        private void ComboBox_LostFocus2(object sender, RoutedEventArgs e)
        {
            var combobox = sender as ComboBox;
            if (combobox == null)
                return;

            var itemText = combobox.Text;
            if (string.IsNullOrWhiteSpace(itemText) ||
                this.MessageTypes.Any(s => s.Name == itemText))
                return;

            this.MessageTypes.Add(new MessageTypeModel
            {
                Name = itemText,
            });
        }

        private void TextBox_LostFocus(object sender, RoutedEventArgs e)
        {
            var tb = sender as TextBox;
            if (tb == null)
                return;

            var be = tb.GetBindingExpression(TextBox.TextProperty);

            if (be.ResolvedSource != null)
            {

                var source = be.ResolvedSource.GetType()
                                             .GetProperty(be.ResolvedSourcePropertyName)
                                             .GetValue(be.ResolvedSource) as string;

                var target = be.Target.GetValue(be.TargetProperty) as string;

                if (!string.IsNullOrWhiteSpace(source) && !string.IsNullOrWhiteSpace(target))
                {
                    var senders = this.Messages.Where(m => m.Sender == source).ToList();
                    var receivers = this.Messages.Where(m => m.Receiver == source).ToList();

                    foreach (var i in senders)
                        i.Sender = target;

                    foreach (var i in receivers)
                        i.Receiver = target;
                }
            }

            be.UpdateSource();

            foreach (var item in this.Services.GroupBy(s => s.Name).SelectMany(s => s.Skip(1).ToList()))
            {
                this.Services.Remove(item);
            }

            foreach (var item in this.Services.Where(i => string.IsNullOrWhiteSpace(i.Name)).ToList())
            {
                this.Services.Remove(item);
            }
        }
        private void TextBox_LostFocus2(object sender, RoutedEventArgs e)
        {
            var tb = sender as TextBox;
            if (tb == null)
                return;

            var be = tb.GetBindingExpression(TextBox.TextProperty);

            if (be.ResolvedSource != null)
            {

                var source = be.ResolvedSource.GetType()
                                             .GetProperty(be.ResolvedSourcePropertyName)
                                             .GetValue(be.ResolvedSource) as string;

                var target = be.Target.GetValue(be.TargetProperty) as string;

                if (!string.IsNullOrWhiteSpace(source) && !string.IsNullOrWhiteSpace(target))
                {
                    var messages = this.Messages.Where(m => m.Name == source).ToList();

                    foreach (var i in messages)
                        i.Name = target;
                }
            }

            be.UpdateSource();

            foreach (var item in this.MessageTypes.GroupBy(s => s.Name).SelectMany(s => s.Skip(1).ToList()))
            {
                this.MessageTypes.Remove(item);
            }

            foreach (var item in this.MessageTypes.Where(i => string.IsNullOrWhiteSpace(i.Name)).ToList())
            {
                this.MessageTypes.Remove(item);
            }
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            var btn = sender as Button;
            var msg = btn.DataContext as MessageModel;

            var s = msg.Sender;
            msg.Sender = msg.Receiver;
            msg.Receiver = s;
        }
    }
}

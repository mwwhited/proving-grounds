using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Diagnostics.Contracts;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Threading;

namespace Ssb.Modeling.Flow.Wpf
{
    public class SequenceDiagramCanvas : Canvas
    {
        public SequenceDiagramCanvas()
        {
            this.EndpointMargin = 20d;
            this.EndpointHeight = 30d;
            this.MessageHeight = 30d;
            this.LineStrokeWidth = 2d;

            this.Bounds = new Collection<BoundModel>();
        }

        public static readonly DependencyProperty SelectedMessageProperty =
            DependencyProperty.Register("SelectedMessage", typeof(MessageModel), typeof(SequenceDiagramCanvas));
        public MessageModel SelectedMessage
        {
            get { return (MessageModel)this.GetValue(SelectedMessageProperty); }
            set { this.SetValue(SelectedMessageProperty, value); }
        }

        private ObservableCollection<MessageModel> _messages;
        public ObservableCollection<MessageModel> Messages
        {
            get { return this._messages; }
            set
            {
                this.RemoveHandler(this._messages);
                this._messages = value;
                this.AddHandler(this._messages);
                this.ForceRender();
            }
        }

        private void AddHandler(IEnumerable enumerable)
        {
            var notifiable = enumerable as INotifyCollectionChanged;
            if (notifiable == null)
                return;

            notifiable.CollectionChanged += this.CollectionChanged;
        }

        private void RemoveHandler(IEnumerable enumerable)
        {
            var notifiable = enumerable as INotifyCollectionChanged;
            if (notifiable == null)
                return;

            notifiable.CollectionChanged -= this.CollectionChanged;
        }

        private void RemoveNotifyHandler(IList list)
        {
            var notifiables = list.OfType<INotifyPropertyChanged>();
            foreach (var notifiable in notifiables)
            {
                notifiable.PropertyChanged -= PropertyChanged;
            }
        }

        private void AddNotifyHandler(IList list)
        {
            var notifiables = list.OfType<INotifyPropertyChanged>();
            foreach (var notifiable in notifiables)
            {
                notifiable.PropertyChanged += PropertyChanged;
            }
        }

        private void CollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            switch (e.Action)
            {
                case NotifyCollectionChangedAction.Add:
                    this.AddNotifyHandler(e.NewItems);
                    break;
                case NotifyCollectionChangedAction.Remove:
                    this.RemoveNotifyHandler(e.OldItems);
                    break;

                case NotifyCollectionChangedAction.Reset:
                case NotifyCollectionChangedAction.Replace:
                    this.RemoveNotifyHandler(e.OldItems);
                    this.AddNotifyHandler(e.NewItems);
                    break;

                case NotifyCollectionChangedAction.Move:
                default:
                    break;
            }

            this.Bounds.Clear();
            this.ForceRender();
        }

        private void PropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if (this.LastDown == null)
                this.Bounds.Clear();
            this.ForceRender();
        }

        private void ForceRender()
        {
            this.InvalidateVisual();
        }

        protected override void OnMouseLeftButtonDown(MouseButtonEventArgs e)
        {
            base.OnMouseLeftButtonDown(e);

            var position = e.GetPosition(this);
            this.LastDown = position;
            this.SelectedBound = this.Bounds.FirstOrDefault(r => r.Rect.Contains(position));
            if (this.SelectedBound != null)
            {
                this.SelectedMessage = this.SelectedBound.Message;
            }
            else
            {
                this.SelectedMessage = null;
            }
            this.ForceRender();
        }

        protected override void OnMouseLeftButtonUp(MouseButtonEventArgs e)
        {
            base.OnMouseLeftButtonUp(e);

            this.SelectedBound = null;
            this.LastDown = null;
            this.SelectedMessage = null;
            this.ForceRender();
        }

        protected override void OnMouseMove(MouseEventArgs e)
        {
            base.OnMouseMove(e);

            if (this.SelectedBound != null)
            {
                var position = e.GetPosition(this);
                if (this.SelectedBound.Type == BoundModel.Types.Message)
                {
                    var existingIndex = this.Messages.IndexOf(this.SelectedBound.Message);
                    if (existingIndex > -1)
                    {

                        var boundMax = this.LastDown.Value.Y + this.EndpointHeight;
                        var boundMin = this.LastDown.Value.Y - this.EndpointHeight;

                        if (position.Y > boundMax && existingIndex < this.Messages.Count - 1)
                        {
                            //Move Up
                            this.Messages.Move(existingIndex, existingIndex + 1);
                            this.LastDown = position;
                        }
                        else if (position.Y < boundMin && existingIndex > 0)
                        {
                            //Move Down
                            this.Messages.Move(existingIndex, existingIndex - 1);
                            this.LastDown = position;
                        }
                    }
                }
                else if (this.SelectedBound.Type == BoundModel.Types.Sender
                        || this.SelectedBound.Type == BoundModel.Types.Receiver)
                {
                    var newEndpoint = this.Bounds.Where(b => b.Type == BoundModel.Types.Endpoint)
                                                 .FirstOrDefault(b => b.Rect.X < position.X && position.X < b.Rect.Right);
                    if (newEndpoint != null)
                    {
                        if (this.SelectedBound.Type == BoundModel.Types.Sender)
                        {
                            if (this.SelectedBound.Message.Sender != newEndpoint.Service)
                                this.SelectedBound.Message.Sender = newEndpoint.Service;
                        }
                        else if (this.SelectedBound.Type == BoundModel.Types.Receiver)
                        {
                            if (this.SelectedBound.Message.Receiver != newEndpoint.Service)
                                this.SelectedBound.Message.Receiver = newEndpoint.Service;
                        }
                    }
                }
            }
        }

        protected override void OnMouseLeave(MouseEventArgs e)
        {
            base.OnMouseLeave(e);

            this.SelectedBound = null;
            this.LastDown = null;
            this.SelectedMessage = null;
            this.ForceRender();
        }

        private ICollection<BoundModel> Bounds { get; set; }
        private BoundModel SelectedBound { get; set; }
        private Point? LastDown { get; set; }

        private double EndpointMargin { get; set; }
        private double EndpointHeight { get; set; }
        private double MessageHeight { get; set; }
        private double LineStrokeWidth { get; set; }


        protected override void OnRender(DrawingContext dc)
        {
            base.OnRender(dc);

            var endpoints = new Dictionary<string, EndpointModel>();

            var currentWidth = 0d;
            var currentHeight = this.EndpointMargin * 2d + this.EndpointHeight + this.EndpointMargin * 2d;

            if (this.Messages != null)
            {
                foreach (var item in this.Messages)
                {
                    var displayName = item.Name ?? "";
                    var senderName = item.Sender ?? "";
                    var receiverName = item.Receiver ?? "";

                    var sender = this.GetEndpoint(senderName, endpoints, dc, ref currentWidth, currentHeight, item);
                    var previous = new Point(sender.CenterX, sender.PreviousBottom);
                    var receiver = this.GetEndpoint(receiverName, endpoints, dc, ref currentWidth, currentHeight, item);

                    //Life Line
                    foreach (var ep in new[] { sender, receiver })
                    {
                        var lifeLineStart = new Point(ep.CenterX, ep.PreviousBottom);
                        var lifeLineEnd = new Point(ep.CenterX, ep.Bottom);
                        dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGreen), this.LineStrokeWidth), lifeLineStart, lifeLineEnd);
                    }

                    var text = this.GetFormattedText(displayName, new SolidColorBrush(Colors.DarkRed));

                    //Message Line
                    var messageStart = new Point(sender.CenterX, currentHeight);
                    Point messageEnd;
                    Point midpoint;

                    if (senderName == receiverName)
                    {
                        //loopback

                        var loopWidth = sender.Width / 2d;
                        var loopHeight = this.EndpointHeight;

                        var message2 = new Point(messageStart.X + loopWidth, messageStart.Y);
                        var message3 = new Point(message2.X, message2.Y + loopHeight);
                        messageEnd = new Point(messageStart.X, message3.Y);

                        midpoint = new Point((message2.X + message3.X) / 2d,
                                             (messageStart.Y + messageEnd.Y) / 2d + text.Height / 2d);

                        currentWidth = Math.Max(midpoint.X + text.Width / 2 + this.EndpointMargin, currentWidth);
                        currentHeight += loopHeight;

                        var lifeLineStart = previous;
                        var lifeLineEnd = new Point(sender.CenterX, sender.Bottom += loopHeight);
                        dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGreen), this.LineStrokeWidth), lifeLineStart, lifeLineEnd);


                        dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGoldenrod), this.LineStrokeWidth), messageStart, message2);
                        dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGoldenrod), this.LineStrokeWidth), message2, message3);
                        dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGoldenrod), this.LineStrokeWidth), message3, messageEnd);
                    }
                    else
                    {
                        messageEnd = new Point(receiver.CenterX, currentHeight);

                        midpoint = new Point((messageStart.X + messageEnd.X) / 2d,
                                             (messageStart.Y + messageEnd.Y) / 2d + text.Height / 2d);

                        dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGoldenrod), this.LineStrokeWidth), messageStart, messageEnd);
                    }


                    // Message Endcap
                    var messageEndTop = new Point(messageEnd.X + (messageEnd.X > messageStart.X ? -1 : 1) * this.EndpointMargin / 2d, messageEnd.Y + this.EndpointMargin / 2d);
                    var messageEndBottom = new Point(messageEnd.X + (messageEnd.X > messageStart.X ? -1 : 1) * this.EndpointMargin / 2d, messageEnd.Y - this.EndpointMargin / 2d);
                    dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGoldenrod), this.LineStrokeWidth), messageEnd, messageEndTop);
                    dc.DrawLine(new Pen(new SolidColorBrush(Colors.DarkGoldenrod), this.LineStrokeWidth), messageEnd, messageEndBottom);

                    // Message Label
                    var textPostion = new Point(midpoint.X - text.Width / 2, // Center X
                                                midpoint.Y - text.Height);    // Top Align Y
                    dc.DrawText(text, textPostion);
                    if (this.LastDown == null)
                    {
                        this.Bounds.Add(new BoundModel
                        {
                            Rect = new Rect(textPostion, new Size(text.Width, text.Height)),
                            Message = item,
                            Type = BoundModel.Types.Message,
                        });
                        this.Bounds.Add(new BoundModel
                        {
                            Rect = new Rect(new Point(messageStart.X - this.EndpointMargin / 2d, messageStart.Y - this.EndpointMargin / 2d),
                                            new Size(this.EndpointMargin, this.EndpointMargin)),
                            Message = item,
                            Type = BoundModel.Types.Sender,
                            Service = senderName,
                        });
                        this.Bounds.Add(new BoundModel
                        {
                            Rect = new Rect(new Point(messageEnd.X - this.EndpointMargin / 2d, messageEnd.Y - this.EndpointMargin / 2d),
                                            new Size(this.EndpointMargin, this.EndpointMargin)),
                            Message = item,
                            Type = BoundModel.Types.Receiver,
                            Service = receiverName,
                        });
                    }

                    currentHeight += this.MessageHeight + this.EndpointMargin;
                }
            }

            this.Width = currentWidth;
            this.Height = currentHeight;

            if (this.SelectedBound != null)
                dc.DrawRectangle(new SolidColorBrush(Colors.Transparent),
                                    new Pen(new SolidColorBrush(Colors.Pink), this.LineStrokeWidth),
                                    this.SelectedBound.Rect);
        }

        private EndpointModel GetEndpoint(string name, IDictionary<string, EndpointModel> endpoints, DrawingContext dc, ref double currentWidth, double currentHeight, MessageModel message)
        {
            Contract.Requires(!string.IsNullOrEmpty(name));
            Contract.Requires(endpoints != null);
            Contract.Requires(dc != null);
            Contract.Ensures(Contract.Result<EndpointModel>() != null);

            EndpointModel model;
            if (endpoints.ContainsKey(name))
            {
                model = endpoints[name];
                model.PreviousBottom = model.Bottom;
            }
            else
            {
                var formattedText = this.GetFormattedText(name, new SolidColorBrush(Colors.DarkRed));
                model = new EndpointModel
                {
                    Name = name,
                    Left = currentWidth,
                    Width = this.EndpointMargin * 2d + formattedText.Width + this.EndpointMargin * 2d,
                    Bottom = currentHeight,
                };
                model.CenterX = currentWidth + model.Width / 2d;

                var textPosition = new Point(x: model.CenterX - formattedText.Width / 2d,
                                             y: this.EndpointMargin + this.EndpointHeight / 2d - formattedText.Height / 2d
                                             );
                var frameRectangle = new Rect(location: new Point(x: currentWidth + this.EndpointMargin, y: this.EndpointMargin),
                                              size: new Size(width: this.EndpointMargin * 2d + formattedText.Width, height: this.EndpointHeight)
                                              );

                if (this.LastDown == null)
                {
                    this.Bounds.Add(new BoundModel
                    {
                        Rect = frameRectangle,
                        Message = message,
                        Type = BoundModel.Types.Endpoint,
                        Service = name,
                    });
                }

                dc.DrawRectangle(new SolidColorBrush(Colors.LightGray),
                                 new Pen(new SolidColorBrush(Colors.Blue), this.LineStrokeWidth),
                                 frameRectangle
                                 );
                dc.DrawText(formattedText, textPosition);
                model.PreviousBottom = frameRectangle.Bottom;

                currentWidth += model.Width;
                endpoints.Add(name, model);
            }

            model.Bottom = currentHeight + this.EndpointMargin;
            return model;
        }

        private FormattedText GetFormattedText(string textValue, Brush textColor)
        {
            Contract.Requires(!string.IsNullOrEmpty(textValue));
            Contract.Requires(textColor != null);
            Contract.Ensures(Contract.Result<FormattedText>() != null);
            return new FormattedText(textValue,
                                     CultureInfo.CurrentUICulture,
                                     FlowDirection.LeftToRight,
                                     new Typeface(new FontFamily("Arial"), FontStyles.Normal, FontWeights.Bold, FontStretches.Normal),
                                     14,
                                     textColor
                                     );
        }
    }
}

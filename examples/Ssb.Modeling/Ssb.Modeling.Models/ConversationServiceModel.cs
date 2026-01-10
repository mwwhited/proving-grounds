using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Ssb.Modeling.Models
{
    public class ConversationServiceModel : ViewModelBase, IEnumerable
    {
        public ConversationServiceModel(string endpoint)
        {
            if (string.IsNullOrWhiteSpace(endpoint))
                throw new ArgumentNullException("endpoint");
            this.Endpoint = endpoint;
        }

        private ServiceModel _service;
        public ServiceModel Service
        {
            get { return this._service; }
            set
            {
                this._service = value;
                this.OnPropertyChanged("Service");
            }
        }

        private string _endpoint;
        public string Endpoint
        {
            get { return this._endpoint; }
            set
            {
                this._endpoint = value;
                this.OnPropertyChanged("Endpoint");
            }
        }

        public IEnumerator GetEnumerator()
        {
            yield return this.Service;
        }
    }
}

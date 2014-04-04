//!javascript

var hosts = [
    "twitter.com",
    "google.tld"
];

var tldRegex = new RegExp("\.tld$");

var stripped = hosts.map(function(v) { return v.substr(0, v.indexOf(".")); });

var matchHost = function(host)
{
    var h, base, name, i;

    base = util.domainFromHost(host);
    name = base.substring(0, base.indexOf("."));

    for (i=hosts.length-1; i>=0; --i)
    {
        h = hosts[i];
        if (tldRegex.test(h))
        {
            if (name == stripped[i])
                return true;
        }
        else if (h == base)
            return true;
    }
    return false;
};

var navigationCallback = function(wv, frame, request)
{
    var id;

    if (wv.mainFrame != frame)
        return false;

    id = wv.getPrivate("id", this);

    if (matchHost(request.message.uri.host))
    {
        if (!id)
        {
            id = wv.connect("resource-request-starting", function(w, frame, resource, request)
            {
                if (request && request.message.uri.scheme == "http")
                    request.uri = "https" + request.uri.substring(4);
            });
            wv.setPrivate("id", id, this);
        }
    }
    else if (id > 0)
    {
        wv.disconnect(id);
        wv.setPrivate("id", 0, this);
    }
    return false;
};

signals.connect("navigation", navigationCallback.bind(this));

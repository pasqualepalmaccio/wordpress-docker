vcl 4.0;

backend wordpress {
    .host = "wordpress";  # Nome esatto del container di WordPress
    .port = "80";
    .connect_timeout = 30s;
    .first_byte_timeout = 120s;
    .between_bytes_timeout = 120s;
}

sub vcl_recv {

    if (req.method == "PURGE") {
        if (!req.http.X-Purge-Token || req.http.X-Purge-Token != "SECURE_PURGE_TOKEN") {
            return (synth(405, "Not allowed"));
        }
        return (purge);
    }


# Evita che WordPress cache il backend e le richieste AJAX
    if (req.url ~ "wp-admin|wp-login|admin-ajax.php|wc-api|cart|my-account|checkout|addons") {
           return (pass);
       }

    # Non cache le query string (es: parametri di tracking)
    if (req.url ~ "\?") {
        return (pass);
    }

    # Cache solo GET e HEAD, bypass POST
    if (req.method != "GET" && req.method != "HEAD") {
        return (pass);
    }

    return (hash);
}

sub vcl_backend_response {
    # Cache solo se il codice HTTP è 200 o 301
    # Cache solo se il codice HTTP è 200 o 301
       if (beresp.status == 200 || beresp.status == 301) {
           if (bereq.url ~ "\.(css|js|ico|gif|jpg|jpeg|png|webp|svg|woff|woff2|ttf|eot|otf|mp4|mp3|avi|mov|mkv|ogg|ogv|webm)(\?.*)?$") {
               set beresp.ttl = 7d;  # Cache dei file statici per 7 giorni
           } else {
               set beresp.ttl = 1h;  # Cache normale di 1 ora
           }
       } else {
           set beresp.ttl = 0s;  # Non cacheare errori
       }
       if (beresp.http.content-type ~ "text/plain" ||
               beresp.http.content-type ~ "text/html" ||
               beresp.http.content-type ~ "text/css" ||
               beresp.http.content-type ~ "text/javascript" ||
               beresp.http.content-type ~ "application/javascript" ||
               beresp.http.content-type ~ "application/json" ||
               beresp.http.content-type ~ "application/xml") {
               set beresp.do_gzip = true;
           }
              if (beresp.status == 404) {
                   set beresp.ttl = 10m;  # Cache solo per 10 minuti
               }
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
    set resp.http.X-Cache-Hits = obj.hits;
    set resp.http.X-Varnish = req.http.X-Varnish;
}
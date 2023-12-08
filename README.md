# Audio over IP

Script e software necessari a attivare su 2 PC Linux jack audio con estensione per il network, allo scopo di inviare audio nelle 2 direzioni

I PC sono normalmente chiamanti regia.local e palco.local (gli hostname vengono risolti usando il protocollo Avahi, il nome va configurato in `avahi-daemon.conf`)
- palco.local invia 2 canali stereo per il preascolto a regia.local
- regia.local invia 2 canali stereo con le basi a palco.local


# D2
Progetto ancora in sviluppo per disegnare lo schemma delle connessioni di X32 a partire dai file .scn


<hr>

### note
systemctl status display-manager



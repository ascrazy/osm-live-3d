A bunch of scripts to spin up local instance of streets-gl with fresh data from OSM

### Usage

* Download .OSM.PBF data and put into `data/sources/planet.osm.pbf`. Possible sources of the data are
* * `wget -O data/sources/planet.osm.pbf http://ftp.snt.utwente.nl/pub/misc/openstreetmap/planet-latest.osm.pbf` - entire planet (~70Gb)
* * [Geofabrik](https://download.geofabrik.de/) - has prebuilt data files for countries and regions
* * [Protomaps](https://protomaps.com/docs/downloads) - let's you choose custom area and download very limited set of data   
* `make refresh-tiles` will build strandedkitty-planetiler image, download water data (~800Mb) and build tiles from the data you put into `data/sources/planet.osm.pbf`
* `make up` will spin up tileserver-gl [localhost:8081](http://localhost:8081) with the data built on the prev step and streets-gl linked up to that tileserver
* Access your streets-gl at [localhost:8080](http://localhost:8080)
build-planetiler:
	docker run -it --rm -v ./strandedkitty-planetiler:/usr/src/planetiler -w /usr/src/planetiler maven:3.8.3-openjdk-17 mvn -q -DskipTests --projects planetiler-dist -am clean package

download-water-polygons:
	mkdir -p ./strandedkitty-planetiler/data/sources  
	wget -O ./strandedkitty-planetiler/data/sources/water.zip https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip
	unzip ./strandedkitty-planetiler/data/sources/water.zip -d ./strandedkitty-planetiler/data/sources

refresh-tiles:
	docker run -it --rm -v ./strandedkitty-planetiler:/usr/src/planetiler -w /usr/src/planetiler maven:3.8.3-openjdk-17 java -cp planetiler-dist/target/planetiler-dist-0.6-SNAPSHOT-with-deps.jar com.onthegomap.planetiler.examples.StreetsProfile

# run-tileserver:
# 	docker run -it --rm -v ./strandedkitty-planetiler/data:/data -p 8081:8080 maptiler/tileserver-gl


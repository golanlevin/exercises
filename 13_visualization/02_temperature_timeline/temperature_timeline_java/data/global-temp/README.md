Global Temperature Time Series. Data are included from the GISS Surface Temperature (GISTEMP) analysis and the global component of Climate at a Glance (GCAG). Two datasets are provided: 1) global monthly mean and 2) annual mean temperature anomalies in degrees Celsius from 1880 to the present.

## Data

### Description

1. [GISTEMP Global Land-Ocean Temperature Index][gistemp]:

  > Combined Land-Surface Air and Sea-Surface Water Temperature Anomalies [i.e. deviations from the corresponding 1951-1980 means]. Global-mean monthly [...] and annual means, 1880-present, updated through most recent month.

1. [Global component of Climate at a Glance (GCAG)][gcag]:

  > Global temperature anomaly data come from the Global Historical Climatology Network-Monthly (GHCN-M) data set and International Comprehensive Ocean-Atmosphere Data Set (ICOADS), which have data from 1880 to the present. These two datasets are blended into a single product to produce the combined global land and ocean temperature anomalies. The available timeseries of global-scale temperature anomalies are calculated with respect to the 20th century average [...].

### Citations

1. *GISTEMP: NASA Goddard Institute for Space Studies (GISS) Surface Temperature Analysis, Global Land-Ocean Temperature Index.*
1. *NOAA National Climatic Data Center (NCDC), global component of Climate at a Glance (GCAG).*

### Sources

1. 
  * Name: GISTEMP Global Land-Ocean Temperature Index
  * Web: http://data.giss.nasa.gov/gistemp
1. 
  * Name: Global component of Climate at a Glance (GCAG)
  * Web: http://www.ncdc.noaa.gov/cag/data-info/global

### Additional Data

* Upstream datasets:
  * [GHCN-M][ghcn-m]
  * [ERSST][ersst]
  * [ICOADS][icoads]
* Other:
  * [HadCRUT4][hadcrut4] time series data are not included in the published Data Package at this time because of the dataset's restrictive [terms and conditions][hadcrut4-terms]. However, the data preparation script supports processing the dataset.

## Preparation

### Requirements

Data preparation requires Python 2.

### Processing

Run the following script from this directory to download and process the data:

```bash
make data
```

Hundredths of degrees Celsius in the GISTEMP Global Land-Ocean Temperature Index data are converted to degrees Celsius.

A HadCRUT4 processing script is available but not run by default.

### Resources

The raw data are output to `./tmp`. The processed data are output to `./data`.

## License

### ODC-PDDL-1.0

This Data Package and these datasets are made available under the Public Domain Dedication and License v1.0 whose full text can be found at: http://www.opendatacommons.org/licenses/pddl/1.0/

### Notes

The upstream datasets do not impose any specific restrictions on using these data in a public or commercial product:

* [GHCN-N](http://www.esrl.noaa.gov/psd/data/gridded/data.ghcncams.html)
* [ERSST](http://www.esrl.noaa.gov/psd/data/gridded/data.noaa.ersst.html)
* [ICOADS](http://icoads.noaa.gov/data.icoads.html)

[gistemp]: http://data.giss.nasa.gov/gistemp/
[gcag]: http://www.ncdc.noaa.gov/cag/data-info/global
[hadcrut4]: http://www.metoffice.gov.uk/hadobs/hadcrut4/data/current/download.html#regional_series
[hadcrut4-terms]: http://www.metoffice.gov.uk/hadobs/hadcrut4/terms_and_conditions.html
[ghcn-m]: http://www.ncdc.noaa.gov/ghcnm/v3.php
[ersst]: http://www.ncdc.noaa.gov/data-access/marineocean-data/extended-reconstructed-sea-surface-temperature-ersst-v3b
[icoads]: http://icoads.noaa.gov/

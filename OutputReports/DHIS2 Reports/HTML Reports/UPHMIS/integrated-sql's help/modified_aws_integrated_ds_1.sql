SELECT * 
FROM   ( 
        (SELECT district, 
                'SC', 
                Count(*) AS registration, 
                startdate 
         FROM   (SELECT district, 
                        count, 
                        startdate 
                 FROM   (SELECT ou2.name district, 
                                ou.organisationunitid 
                         FROM   organisationunit ou 
                                inner join _orgunitstructure os 
                                        ON ou.organisationunitid = 
                                           os.organisationunitid 
                                inner join organisationunit ou2 
                                        ON ou2.organisationunitid = os.idlevel4 
                                         where ou2.uid like '${orgunit}'
                         GROUP  BY ou2.name, 
                                   ou.organisationunitid 
                         ORDER  BY district)kapi 
                        inner join (SELECT Count(DISTINCT DATE), 
                                           cd.sourceid, 
                        Substring(cd.date :: VARCHAR, 1, 7) AS 
                        startdate 
                                    FROM   completedatasetregistration cd 
                                           inner join period p 
                                                   ON p.periodid = cd.periodid 
                                    WHERE  datasetid = 119902174
                                           AND CAST(cd.date AS DATE)  >= 
                                                        '${startdate}'  AND 
														CAST(cd.date AS DATE)<=
                                                         '${enddate}'  
												and extract(month from cd.date)= extract(month from p.startdate)  
                                    GROUP  BY cd.sourceid, 
                                              cd.date)kapi2 
                                ON kapi2.sourceid = kapi.organisationunitid) 
                kapi3 
         GROUP  BY startdate, 
                   district 
         ORDER  BY district) 

        UNION 
        (SELECT district, 
                'Total', 
                Count(*) AS registration, 
                startdate 
         FROM   (SELECT district, 
                        count, 
                        startdate 
                 FROM   (SELECT ou2.name district, 
                                ou.organisationunitid 
                         FROM   organisationunit ou 
                                inner join _orgunitstructure os 
                                        ON ou.organisationunitid = 
                                           os.organisationunitid 
                                inner join organisationunit ou2 
                                        ON ou2.organisationunitid = os.idlevel4 
                                         where ou2.uid like '${orgunit}'
                         GROUP  BY ou2.name, 
                                   ou.organisationunitid 
                         ORDER  BY district)kapi 
                        inner join (SELECT Count(DISTINCT DATE), 
                                           cd.sourceid, 
                        Substring(cd.date :: VARCHAR, 1, 7) AS 
                        startdate 
                                    FROM   completedatasetregistration cd 
                                           inner join period p 
                                                   ON p.periodid = cd.periodid 
                                    WHERE  datasetid IN (119902174) 
                                           AND CAST(cd.date AS DATE)  >= 
                                                        '${startdate}'  AND 
														CAST(cd.date AS DATE)<=
                                                         '${enddate}'  
												and extract(month from cd.date)= extract(month from p.startdate)  
                                    GROUP  BY cd.sourceid, 
                                              cd.date)kapi2 
                                ON kapi2.sourceid = kapi.organisationunitid) 
                kapi3 
         GROUP  BY startdate, 
                   district 
         ORDER  BY district))kapp 
ORDER  BY district 
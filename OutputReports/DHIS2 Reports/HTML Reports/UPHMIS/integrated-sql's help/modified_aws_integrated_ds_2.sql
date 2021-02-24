SELECT * 
FROM   ((SELECT * 
         FROM   ((SELECT  
                         district, 
                         block,
                         Count(*) AS registration, 
                         'SC'     AS facilityType, 
                         startdate 
                  FROM   (SELECT  
                                 district,
                                 block, 
                                 count, 
                                 startdate 
                          FROM   (SELECT   
                                         ou1.name district,
                                         ou3.name block, 
                                         ou.organisationunitid 
                                  FROM   organisationunit ou 
                                         inner join _orgunitstructure os 
                                                 ON ou.organisationunitid = 
                                                    os.organisationunitid 
                                         inner join organisationunit ou2 
                                                 ON ou2.organisationunitid = 
                                                    os.idlevel3 
                                         inner join organisationunit ou1 
                                                 ON ou1.organisationunitid = 
                                                    os.idlevel4 
                                                    inner join organisationunit ou3 
                                                 ON ou3.organisationunitid = 
                                                    os.idlevel5
                                                    where ou1.uid like '${orgunit}'
                                  GROUP  BY ou1.name, 
                                             
                                            ou3.name,
                                            ou.organisationunitid 
                                  ORDER  BY district)kapi 
                                 inner join (SELECT Count(DISTINCT DATE), 
                                                    cd.sourceid, 
                                 Substring(cd.date :: VARCHAR, 1, 7) AS 
                                 startdate 
                                             FROM   completedatasetregistration 
                                                    cd 
                                                    inner join period p 
                                                            ON p.periodid = 
                                                               cd.periodid 
                                             WHERE  datasetid = 119902174
                                                    AND CAST(cd.date AS DATE)  >= 
                                                        '${startdate}'  AND 
														CAST(cd.date AS DATE)<=
                                                         '${enddate}'  
														and extract(month from cd.date)= extract(month from p.startdate)
                                             GROUP  BY cd.sourceid, 
                                                       cd.date)kapi2 
                                         ON 
                                 kapi2.sourceid = kapi.organisationunitid) 
                         kapi3 
                  GROUP  BY  
                            district,
                            block, 
                            startdate 
                  ORDER  BY district) 
   
                 UNION 
                 (SELECT  
                         district,block, 
                         Count(*) AS registration, 
                         'Total'  AS facilityType, 
                         startdate 
                  FROM   (SELECT  
                                 district,block,
                                 count, 
                                 startdate 
                          FROM   (SELECT   
                                         ou1.name district,
                                         ou3.name block, 
                                         ou.organisationunitid 
                                  FROM   organisationunit ou 
                                         inner join _orgunitstructure os 
                                                 ON ou.organisationunitid = 
                                                    os.organisationunitid 
                                         inner join organisationunit ou2 
                                                 ON ou2.organisationunitid = 
                                                    os.idlevel3 
                                         inner join organisationunit ou1 
                                                 ON ou1.organisationunitid = 
                                                    os.idlevel4 
                                                    inner join organisationunit ou3 
                                                 ON ou3.organisationunitid = 
                                                    os.idlevel5
                                                    where ou1.uid like '${orgunit}'
                                  GROUP  BY ou1.name, 
                                             
                                            ou3.name,
                                            ou.organisationunitid 
                                  ORDER  BY district)kapi 
                                 inner join (SELECT Count(DISTINCT DATE), 
                                                    cd.sourceid, 
                                 Substring(cd.date :: VARCHAR, 1, 7) AS 
                                 startdate 
                                             FROM   completedatasetregistration 
                                                    cd 
                                                    inner join period p 
                                                            ON p.periodid = 
                                                               cd.periodid 
                                             WHERE  datasetid IN ( 
                                                    119902174
                                                                 ) 
                                                    AND CAST(cd.date AS DATE)  >= 
                                                        '${startdate}'  AND 
														CAST(cd.date AS DATE)<=
                                                         '${enddate}'  
														and extract(month from cd.date)= extract(month from p.startdate)
                                             GROUP  BY cd.sourceid, 
                                                       cd.date)kapi2 
                                         ON 
                                 kapi2.sourceid = kapi.organisationunitid) 
                         kapi3 
                  GROUP  BY  
                            district,block, 
                            startdate 
                  ORDER  BY district))kk 
         ORDER  BY  
                   district,block, 
                   startdate) 
        UNION 
        (SELECT 'District Total', 
                '', 
                Count(*) AS registration, 
                '', 
                startdate 
         FROM   (SELECT  
                        district,block, 
                        count, 
                        startdate 
                 FROM   (SELECT   
                                         ou1.name district,
                                         ou3.name block, 
                                         ou.organisationunitid 
                                  FROM   organisationunit ou 
                                         inner join _orgunitstructure os 
                                                 ON ou.organisationunitid = 
                                                    os.organisationunitid 
                                         inner join organisationunit ou2 
                                                 ON ou2.organisationunitid = 
                                                    os.idlevel3 
                                         inner join organisationunit ou1 
                                                 ON ou1.organisationunitid = 
                                                    os.idlevel4 
                                                    inner join organisationunit ou3 
                                                 ON ou3.organisationunitid = 
                                                    os.idlevel5
                                                    where ou1.uid like '${orgunit}'
                                  GROUP  BY ou1.name, 
                                             
                                            ou3.name,
                                            ou.organisationunitid 
                                  ORDER  BY district)kapi 
                        inner join (SELECT Count(DISTINCT DATE), 
                                           cd.sourceid, 
                        Substring(cd.date :: VARCHAR, 1, 7) AS 
                        startdate 
                                    FROM   completedatasetregistration cd 
                                           inner join period p 
                                                   ON p.periodid = cd.periodid 
                                    WHERE  datasetid IN ( 119902174 
                                                         
                                                        ) 
                                           AND CAST(cd.date AS DATE)  >= 
                                                        '${startdate}'  AND 
														CAST(cd.date AS DATE)<=
                                                         '${enddate}'  
											  and extract(month from cd.date)= extract(month from p.startdate)
                                    GROUP  BY cd.sourceid, 
                                              cd.date)kapi2 
                                ON kapi2.sourceid = kapi.organisationunitid) 
                kapi3 
         GROUP  BY startdate))kkkk 
ORDER  BY  
          district,block, 
          startdate 
SELECT * 
FROM   ((SELECT * 
         FROM   ((SELECT  
                          
                         block,facility,
                         Count(*) AS registration, 
                         'SC'     AS facilityType, 
                         startdate 
                  FROM   (SELECT  
                               block,facility, 
                                 count, 
                                 startdate 
                          FROM   (SELECT   
                                          
                                         ou3.name block,ou4.name facility,
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
                                                    inner join organisationunit ou4 
                                                 ON ou4.organisationunitid = 
                                                    os.idlevel6
                                                    where ou3.uid like '${orgunit}'
                                  GROUP  BY  ou3.name,ou4.name,
                                            ou.organisationunitid 
                                  ORDER  BY block)kapi 
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
                                                    AND cd.date BETWEEN 
                                                        '${startdate}'  AND 
                                                         '${enddate}'  
														 and extract(month from cd.date)= extract(month from p.startdate)
                                             GROUP  BY cd.sourceid, 
                                                       cd.date)kapi2 
                                         ON 
                                 kapi2.sourceid = kapi.organisationunitid) 
                         kapi3 
                  GROUP  BY  
                             block,facility, 
                            startdate 
                  ORDER  BY block) 
                 UNION 

                 (SELECT  
                         block,facility, 
                         Count(*) AS registration, 
                         'Total'  AS facilityType, 
                         startdate 
                  FROM   (SELECT  
                                 block,facility,
                                 count, 
                                 startdate 
                          FROM   (SELECT   
                                          
                                         ou3.name block,ou4.name facility, 
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
                                                        inner join organisationunit ou4 
                                                 ON ou4.organisationunitid = 
                                                    os.idlevel6
                                                    where ou3.uid like '${orgunit}'
                                  GROUP  BY  
                                             
                                            ou3.name,ou4.name,
                                            ou.organisationunitid 
                                  ORDER  BY block)kapi 
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
                                                    AND cd.date BETWEEN 
                                                        '${startdate}'  AND 
                                                         '${enddate}'  
														 and extract(month from cd.date)= extract(month from p.startdate)
                                             GROUP  BY cd.sourceid, 
                                                       cd.date)kapi2 
                                         ON 
                                 kapi2.sourceid = kapi.organisationunitid) 
                         kapi3 
                  GROUP  BY  
                            block,facility, 
                            startdate 
                  ORDER  BY block))kk 
         ORDER  BY  
                   block,facility, 
                   startdate) 
        UNION 
        (SELECT 'Block Total', '',
                
                Count(*) AS registration, 
                '', 
                startdate 
         FROM   (SELECT  
                        block,facility, 
                        count, 
                        startdate 
                 FROM   (SELECT   
                                          
                                         ou3.name block,ou4.name facility, 
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
                                                        inner join organisationunit ou4 
                                                 ON ou4.organisationunitid = 
                                                    os.idlevel6
                                                    where ou3.uid like '${orgunit}'
                                  GROUP  BY  
                                             
                                            ou3.name,ou4.name,
                                            ou.organisationunitid 
                                  ORDER  BY block)kapi 
                        inner join (SELECT Count(DISTINCT DATE), 
                                           cd.sourceid, 
                        Substring(cd.date :: VARCHAR, 1, 7) AS 
                        startdate 
                                    FROM   completedatasetregistration cd 
                                           inner join period p 
                                                   ON p.periodid = cd.periodid 
                                    WHERE  datasetid IN ( 119902174       ) 
                                           AND cd.date BETWEEN 
                                               '${startdate}'  AND  '${enddate}'  
											   and extract(month from cd.date)= extract(month from p.startdate)
                                    GROUP  BY cd.sourceid, 
                                              cd.date)kapi2 
                                ON kapi2.sourceid = kapi.organisationunitid) 
                kapi3 
         GROUP  BY startdate))kkkk 
ORDER  BY  
          block,facility, 
          startdate 
cases := DATASET([{'May 1', 10000}, {'May 2', 9000}, {'May 3', 11000}], {STRING day, REAL value});

recovered := DATASET([{'May 1', 300}, {'May 2', 600}, {'May 3', 700}], {STRING day, REAL value});

cases_country := DATASET([{'May 1', 'US', 300}, 
                          {'May 2', 'US' , 600}, 
                          {'May 3', 'US' ,700},
                          {'May 1', 'UK', 400}, 
                          {'May 2', 'UK' , 700}, 
                          {'May 3', 'UK' ,900}], {STRING day, STRING country, REAL value});

OUTPUT(cases,,NAMED('cases'));
OldSort := SORT(cases,value) : DEPRECATED('Use NewSort instead.');
OUTPUT(OldSort);
OUTPUT(recovered,,NAMED('recovered'));
OUTPUT(cases_country,,NAMED('cases_country'));

dashData := DATASET([{'Daily Cases', 'cases', 'Scatter', '{"xField": "day", "yField": "value"}'},
                     {'Daily Cases Recovered', 'recovered', 'Radar', '{"radiusField": "value", "angleField": "day"}'},
                     {'Daily Cases By Country', 'cases_country', 'GroupedBar', '{"xField": "value", "yField": "day", "groupField": "country"}'},
                     {'Daily Cases By Country', 'cases_country', 'StackedBar', '{"xField": "value", "yField": "day", "stackField": "country"}'}],
                     {STRING title, STRING data_source, STRING chart_type, STRING options});

OUTPUT(dashData,,NAMED('_dashboard'));
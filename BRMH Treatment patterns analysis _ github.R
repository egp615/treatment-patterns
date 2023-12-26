
#install.packages("remotes")
#remotes::install_github("mi-erasmusmc/TreatmentPatterns")
#remotes::install_github("OHDSI/ROhdsiWebApi",force = TRUE)

library(ROhdsiWebApi)
baseUrl =  "http://cdm.brmh.org/WebAPI"
authorizeWebApi(baseUrl, 
                authMethod = "db", 
                webApiUsername = "****", 
                webApiPassword = "****")
getCdmSources(baseUrl)


library(TreatmentPatterns)
Sys.setenv("DATABASECONNECTOR_JAR_FOLDER" = "c://Temp//jdbcDrivers")
dataSettings <- createDataSettings(OMOP_CDM = TRUE,
                                   connectionDetails = DatabaseConnector::
                                     createConnectionDetails(dbms = "postgresql",
                                                             server = "****",
                                                             user = "****",
                                                             password = "****",
                                                             port = '****'),
                                   cdmDatabaseSchema = 'cdm',
                                   cohortDatabaseSchema = '****',
                                   cohortTable = "cohort")


cohortSettings <-
  createCohortSettings(
    targetCohorts = data.frame(cohortId = c(54,103,110),
                               atlasId = c(54,103,110),
                               cohortName = c('T2DM','HTN','Depression'),
                               conceptSet = ""),
    eventCohorts = data.frame(cohortId = c(55,56,95,96,97,98,99,100,101,102,
                                           104,105,106,107,111,112,113,
                                           114,115,116,117,118,119,120,121),                           atlasId = c(""),
                              cohortName = c('Alpha-glucosidase inhibitors', 'Biguanides','DPP-4 inhibitors',
                                             'GLP-1 receptor agonists', 'Insulin', 'Meglitinides', 'Other anti-diabetics',
                                             'SGLT2 inhibitors', 'Sulfonylureas', 'Thiazolidinediones',
                                             'ACE inhibitors', 'Alpha-1 blockers',  'ARBs', 'Beta blockers',
                                             'CCBs', 'Direct vasodilators',  'Diuretics',
                                             'Electroconvulsive therapy',
                                             'NDRIs',
                                             'Psychotherapy',
                                             'SSRIs',
                                             'SARIs',
                                             'SNRIs',
                                             'Tetracyclic antidepressants',
                                             'TCAs'  ),
                              conceptSet = c("1510202; 1529331",
                                             "1593986; 1503297; 19033909; 40798673",
                                             "1580747; 19122137; 40166035; 40239216; 43013884",
                                             "793143; 1583722; 40170911; 44506754; 44816332; 45774435",
                                             "1596977; 1550023; 1567198; 1502905; 1513876; 1531601; 1586346;
                                              1544838; 1516976; 1590165; 1513849; 1562586; 1588986; 1513843;
                                              1586369; 35605670; 35602717; 21600713; 19078608",
                                             "1502826; 1516766",
                                             "1529331; 1530014; 730548; 19033498; 19001409; 19059796; 19001441;
                                              1510202; 1502826; 1525215; 1516766; 1547504; 1515249",
                                             "793293; 43526465; 44785829; 45774751",
                                             "1502809; 1502855; 1559684; 1560171; 1594973; 1597756; 19097821",
                                             "1547504; 1525215; 1515249",
                                             "1335471; 1340128; 1341927; 1363749; 1308216; 1310756; 1373225; 1331235; 1334456; 1342439",
                                             "1363053; 1350489; 1341238",
                                             "40235485; 1351557; 1346686; 1347384; 1367500; 40226742; 1317640; 1308842",
                                             "1319998; 1314002; 1322081; 1338005; 1346823; 1386957; 1307046; 1313200; 1314577; 1327978; 1345858; 1353766",
                                             "1332418; 1328165; 1353776; 1326012; 1318137; 1318853; 1319880; 1307863",
                                             "1373928",
                                             "991382; 932745; 1309799; 956874; 970250; 942350; 904542",
                                             "2007727; 2007728; 2108578; 2108579; 2213552; 4004830; 4020981; 4030840;
                                             4111663; 4210144; 4210145; 4332436; 4336318; 44508134",
                                             "750982",
                                             "2007730;2007731;2007746;2007747;2007748;2007749;2007750;2007763;2108571;2213520;
                                             2213521;2213522;2213523;2213524;2213525;2213526;2213527;2213528;2213529;2213530;
                                             2213531;2213532;2213533;2213534;2213535;2213536;2213537;2213538;2213539;2213540;
                                             2213541;2213542;2213543;2213544;2213546;2213547;2213548;2213549;2213550;2213554;
                                             2213555;2617477;2617478;4012488;4028920;4035812;4048385;4048387;4079500;4079608;
                                             4079938;4079939;4080044;4080048;4083129;4083130;4083131;4083133;4083706;4084195;
                                             4084201;4084202;4088889;4100341;4103512;4114491;4117915;4118797;4118798;4118800;
                                             4118801;4119334;4119335;4121662;4126653;4128268;4128406;4132436;4136352;4137086;
                                             4143316;4148398;4148765;4151904;4164790;4173581;4179241;4196062;4199042;4202234;
                                             4208314;4219683;4221997;4225728;4226275;4226276;4233181;4234402;4234476;4242119;
                                             4249602;4258834;4262582;4263758;4265313;4268909;4272803;4278094;4295027;4296166;
                                             4299728;4311943;4327941;40482841;43527904;43527905;43527986;43527987;43527988;43527989;
                                             43527990;43527991;44791916;44792695;44808259;44808677;45763911;45765516;45887728;45887951;
                                             45888237;45889353;46286330;46286403",
                                             "797617; 715939; 755695; 722031; 739138; 40234834",
                                             "703547",
                                             "717607; 715259; 743670",
                                             "725131",
                                             "710062; 738156; 721724")),
    baseUrl =  "http://cdm.brmh.org/WebAPI",
    loadCohorts = TRUE)

characterizationSettings <-
  createCharacterizationSettings(baselineCovariates =
                                   data.frame(covariateName = c('Male', 'Age', 'Charlson comorbidity index score',
                                                                'Cerebrovascular disease','Depressive disorder',
                                                                'Diabtes mellitus', 'Heart failure',
                                                                'Hypertensive disorder', 'Ischemic heart disease',
                                                                'Kidney disease', 'Obesity'),
                                              covariateId = c(8507001, 1002, 1901,
                                                              381591209, 440383209,
                                                              201820209, 316139209,
                                                              316866209, 4185932209,
                                                              198124209, 433736209)),
                                 returnCovariates = "selection")

pathwaySettings <- createPathwaySettings(
  pathwaySettings_list =list(addPathwaySettings(studyName = c("T2DM"),
                                                targetCohortId = 54,
                                                eventCohortIds = c(55,56,95,96,97,98,99,100,101,102)),
                             addPathwaySettings(studyName = c("HTN"),
                                                targetCohortId = 103,
                                                eventCohortIds = c(104,105,106,107,111,112,113)),
                             addPathwaySettings(studyName = c("Depression"),
                                                targetCohortId = 110,
                                                eventCohortIds = c(114,115,116,117,118,119,120,121))))






tmentPatterns::launchResultsExplorer(saveSettings = saveSettings)
TreatmentPatterns::launchResultsExplorer(outputFolder = file.path(saveSettings$rootFolder, "output"))
TreatmentPatterns::launchResultsExplorer(zipFolder = saveSettings$rootFolder)

generateOutput(saveSettings)


###
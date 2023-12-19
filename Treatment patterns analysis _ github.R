install.packages("remotes")
remotes::install_github("mi-erasmusmc/TreatmentPatterns")

library(TreatmentPatterns)
Sys.setenv("DATABASECONNECTOR_JAR_FOLDER" = "c://Temp//jdbcDrivers")
dataSettings <- createDataSettings(OMOP_CDM = TRUE,
                                   connectionDetails = DatabaseConnector::
                                     createConnectionDetails(dbms = "postgresql",
                                                             server = "100.100.***.***",
                                                             user = "****",
                                                             password = "****",
                                                             port = '****'),
                                   cdmDatabaseSchema = 'cdm',
                                   cohortDatabaseSchema = '****',
                                   cohortTable = "cohort")


cohortSettings <-
  createCohortSettings(
    targetCohorts = data.frame(cohortId = c(54),
                               atlasId = c(54), 
                               cohortName = c('T2DM'),
                               conceptSet = ""),
    eventCohorts = data.frame(cohortId = c(55,56,95,96,97,98,99,100,101,102),                            atlasId = c(""),
                              cohortName = c('Alpha-glucosidase inhibitors', 'Biguanides','DPP-4 inhibitors',
                                             'GLP-1 receptor agonists', 'Insulin', 'Meglitinides', 'Other anti-diabetics',
                                             'SGLT2 inhibitors', 'Sulfonylureas', 'Thiazolidinediones'),
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
                                             "1547504; 1525215; 1515249")),
    baseUrl =  "http://cdm.brmh.org/WebAPI",
    loadCohorts = TRUE)

characterizationSettings <-
  createCharacterizationSettings(baselineCovariates =
                                   data.frame(covariateName = c('Male', 'Age',
                                                                'Charlson comorbidity index score'),
                                              covariateId = c(8507001, 1002, 1901)),
                                 returnCovariates = "selection")

pathwaySettings <- createPathwaySettings(
  pathwaySettings_list =list(addPathwaySettings(studyName = c("T2DM"),
                                                targetCohortId = 54,
                                                eventCohortIds = c(55,56,95,96,97,98,99,100,101,102))))


setwd("F:/ATLAS/TreatmentPatterns/TEST"); getwd()
#Sysings <- createSaveSettings(databaseName = "brmhcdm", rootFolder = getwd())

TreatmentPatterns::executeTreatmentPatterns(dataSettings = dataSettings,
                                            cohortSettings = cohortSettings,
                                            characterizationSettings = characterizationSettings,
                                            pathwaySettings = pathwaySettings,
                                            saveSettings = saveSettings)



##????tPatterns::launchResultsExplorer(saveSettings = saveSettings)
TreatmentPatterns::launchResultsExplorer(outputFolder = file.path(saveSettings$rootFolder, "output"))
TreatmentPatterns::launchResultsExplorer(zipFolder = saveSettings$rootFolder)

generateOutput(saveSettings)





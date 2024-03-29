<span class="logo"><img src="https://efmi.org/wp-content/uploads/2019/11/EFMI_Logo_new_wg-587x235.png" alt="EFMI Working Groups Logo" width="125"></span>
<span class="logo"><img src="https://www.nfdi4health.de/images/logo/nfdi4health.svg" alt="NFDI4Health Logo" width="125"></span>
<span class="logo"><img src="https://www.medizininformatik-initiative.de/themes/custom/mii/assets/img/Logo_MII_270px_Hoehe_de.png" alt="MII Logo" width="125"></span>

# Practical Exercises

## Basic options for adding metadata to research studies
Here are some hints how to add metadata as FHIR elements to your research study.

### Starting from Scatch
For those who have not yet worked with FSH, there is a [comprehensive example](./walkthrough.md).

### Starting from examples
If you do not want to start with an empty study, you can copy the JSON code from one of the following examples.

* [NFDI4Health Example Study](https://simplifier.net/NFDI4Health-Metadata-Schema/NFDI4Health_PR_MDS_Study/~json)
* [MII Beispielstudie](https://simplifier.net/medizininformatik-initiative-modul-studien/fsh-generated-resources-researchstudy-mii-exa-studie-studie)
* [List of examples for instances of FHIR R4 ResearchStudy on Simplifier](https://simplifier.net/search?fhir=r4&category=Example&resource=ResearchStudy&Term=) - examples of varying quality
* [ClinicalTrials.gov-to-FEvIR Converter](https://fevir.net/ctgovconvert) by Computable Publishing® - creates an FHIR R6-alpha ResearchStudy from a given NCT ID. This means cheating and your conference ticket will be void!

## Reference Example L2H
As a reference example and to show the expressiveness of different Implmentation Guides, we developed serializations in different formats for an overarching clinical trial: LIVERT(W)OHEAL (L2H).

### Normative references
* [LIVERT(W)OHEAL in clinicaltrials.gov](https://beta.clinicaltrials.gov/study/NCT03488953)

### FHIR conforming to R4
* [L2H in R4](./assets/json/L2H-R4.zip)
  * plus conforming to [NFDI4Health MDS](https://simplifier.net/nfdi4health-metadata-schema/~resources?category=Profile) profiles
  * plus conforming to [MII Module Research Studies](https://simplifier.net/medizininformatik-initiative-modul-studien/~resources?category=Profile) profiles


### FHIR conforming to R4B
* [L2H in R4b](./assets/json/L2H-R4B.zip), conforming to [FHIR4FAIR](https://build.fhir.org/ig/HL7/fhir-for-fair/artifacts.html) profiles

### FHIR conforming to R5
* [L2H in R5](./assets/json/L2H-R5.zip)


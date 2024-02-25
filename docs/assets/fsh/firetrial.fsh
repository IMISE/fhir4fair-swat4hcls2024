Alias: $icd-10 = http://hl7.org/fhir/sid/icd-10
Alias: $sct = http://snomed.info/sct

Instance: firetrial
InstanceOf: ResearchStudy
Usage: #example
* meta.profile = "http://hl7.org/fhir/uv/fhir-for-fair/StructureDefinition/ResearchStudy-uv-f4f"
* status = #in-review
* title = "FAIRness in FHIR"
* description = "A study assessing the **FAIRness** of FHIR artifacts."
* note.text = "Study design is still unclear."
* period.start = "2024-02-26T09:00:00+01:00"
* period.end = "2024-12"
* identifier.use = #official
* identifier.system = "https://clinicaltrials.gov"
* identifier.value = "NCT05487991"
* contact[0].name = "Dr. Franziska Jauch"
* contact[=].telecom.system = #email
* contact[=].telecom.value = "fjauch@uniklinikum-ulm.de"
* contact[=].telecom.use = #work
* contact[+].name = "Wiktor Silberk"
* contact[=].telecom.system = #phone
* contact[=].telecom.value = "+49 1715 8264023"
* contact[=].telecom.use = #mobile
* condition.text = "Cholera"
* condition.coding[0] = $icd-10#A00.0
* condition.coding[=].version = "2024"
* condition.coding[+] = $sct#240349003
* condition.coding[=].version = "http://snomed.info/sct/900000000000207008/version/20230731"
* sponsor = Reference(firetrial-sponsor)
* principalInvestigator = Reference(firetrial-pi)
* extension[0].url = "http://hl7.org/fhir/uv/fhir-for-fair/StructureDefinition/licenceCodeable"
* extension[=].valueCodeableConcept = http://hl7.org/fhir/spdx-license#MIT "MIT License"

Instance: firetrial-sponsor
InstanceOf: Organization
Usage: #example
* name = "Ulm University Hospital"

Instance: firetrial-pi
InstanceOf: Practitioner
Usage: #example
* name.text = "Prof. Dr. T. Ester"

<span class="logo"><img src="https://efmi.org/wp-content/uploads/2019/11/EFMI_Logo_new_wg-587x235.png" alt="EFMI Working Groups Logo" width="125"></span>
<span class="logo"><img src="https://www.nfdi4health.de/images/logo/nfdi4health.svg" alt="NFDI4Health Logo" width="125"></span>
<span class="logo"><img src="https://www.medizininformatik-initiative.de/themes/custom/mii/assets/img/Logo_MII_270px_Hoehe_de.png" alt="MII Logo" width="125"></span>

# Walk through

This walk-through is intended for interested parties who have not yet worked intensively with FSH.

## 0. Dry run

* Open [https://fshschool.org/FSHOnline/#/](https://fshschool.org/FSHOnline/#/).

<a href="./assets/img/wt01-fsh-online.png"><img src="./assets/img/wt01-fsh-online.png" width="100"/></a>

On the left-hand side you can see the editor for FSH, on the right-hand side the editor for FHIR-JSON. You can edit in both and then transfer the changes to the other side using "Convert to".

FSH Online provides useful templates.

* Go to "FSH Examples" and then to "Instances >> Instance Example".

<a href="./assets/img/wt02-fsh-example.png"><img src="./assets/img/wt02-fsh-example.png" width="100"/></a>

* Click on "Clipboard", "Close" and paste the content in the left panel. Click "Convert to JSON".

<a href="./assets/img/wt03-fsh-patient.png"><img src="./assets/img/wt03-fsh-patient.png" width="100"/></a>

That's how it works basically. A new tab has appeared on the right-hand side; several FHIR resources can be created from one FSH file.

You can now validate the example to be sure.

* Copy the content of the right panel.
* Open [https://inferno.healthit.gov/validator/](https://inferno.healthit.gov/validator/).
* Paste the content and click "Validate".

<a href="./assets/img/wt04-inferno.png"><img src="./assets/img/wt04-inferno.png" width="100"/></a>

There should be no errors, only some warnings.

<a href="./assets/img/wt05-inferno-valid.png"><img src="./assets/img/wt05-inferno-valid.png" width="100"/></a>

## 1. Creating an empty study

* Open [https://fshschool.org/FSHOnline/#/](https://fshschool.org/FSHOnline/#/) and delete everything possibly left in the FSH tab.
* Enter the code snippet below and substitude the name of the instance with your pref Press "Convert to JSON".

```
Instance: firetrial
InstanceOf: ResearchStudy
Description: "Example of a research study"
Usage: #example
```

<a href="./assets/img/wt06-researchstudy-template.png"><img src="./assets/img/wt06-researchstudy-template.png" width="100"/></a>

It generates some JSON code, but there is obviously a mistake.

> error Element ResearchStudy.status has minimum cardinality 1 but occurs 0 time(s).
> Line: 1 - 4

The ResearchStudy has a mandatory field called status in FHIR and this is missing.

## 2. Adding study status (code from a controlled vocabulary)

If we look at the specification of [ResearchStudy](https://hl7.org/fhir/R4/researchstudy.html#resource) in FHIR R4, we see that the cardinality of status is 1..1.

<a href="./assets/img/wt07-fhir-r4-researchstudy.png"><img src="./assets/img/wt07-fhir-r4-researchstudy.png" width="100"/></a>

We need to specify a value for status. The data type is code, i.e. it is a value from a predefined set. FHIR distinguishes between different degrees of strictness as to whether the value must actually be taken from the given values. This is the case with (Required). You can find out what the individual codes mean by clicking on ResearchStudyStatus.

```
* status = #in-review
```

All other elements are optional in the generic resource. Now no more errors are returned and the validation would also work.

<a href="./assets/img/wt08-rs-status.png"><img src="./assets/img/wt08-rs-status.png" width="100"/></a>

## 3. Adding the study title (string)

The title of the study is a simple string.

```
* title = "FAIRness in FHIR"
```

## 4. Adding a description (markdown)

The description of a study is of type markdown and is assigned in the same way, except that the receiving system must be able to handle markdown syntax.

```
* description = "A study assessing the **FAIRness** of FHIR artifacts."
```

## 5. Adding a note (Annotation)

```
* note = "Study design is still unclear."
```

Although it was about text again, it didn't work this time.

<a href="./assets/img/wt09-annotation.png"><img src="./assets/img/wt09-annotation.png" width="100"/></a>

The data type of note is [Annotation](https://hl7.org/fhir/R4/datatypes.html#Annotation) and this is not a primitive data type. An annotation can have an author and a creation date. We now want to dispense with this and only use the text element.

```
* note.text = "Study design is still unclear."
```

No problem while converting. 

## 6. Adding the start and end date/time of a study (Period)

Adding dates is very similar to strings, except that a [predefined format](https://www.hl7.org/fhir/datatypes-examples.html) must be adhered to. A FHIR [Period](https://www.hl7.org/fhir/datatypes.html#Period) has an optional start and end of type datetime.

Therefore, not only dates are possible. Our example study starts today in the morning and ends in December.

```
* period.start = "2024-02-26T09:00:00+01:00"
* period.end = "2024-12"
```

<a href="./assets/img/wt10-fsh-period.png"><img src="./assets/img/wt10-fsh-period.png" width="100"/></a>

## 7. Adding the study id (Identifier)

An important criterion for findability in FAIR is a persistent identifier. Interventional clinical trials must be prospectively registered in a trial registry from which they receive an identifier. For example, we register our study in the international [ClinicalTrials.gov](https://clinicaltrials.gov/) register and receive the CT.gov number NCT05487991.

The fact that this is a universal business identifier is made clear with additional information.

```
* identifier[0].use = #official
* identifier[=].system = "https://clinicaltrials.gov"
* identifier[=].value = "NCT05487991"
```

<a href="./assets/img/wt11-fsh-identifier.png"><img src="./assets/img/wt11-fsh-identifier.png" width="100"/></a>

## 8. Adding contacts (multiple values)

Next, we would like to specify two people from the study's environment who serve as medical and organizational contacts. The element [contact](https://hl7.org/fhir/R4/researchstudy.html#resource) must be specified multiple times for this. This is very easy to do with FSH. The first instance is given an index [0]. Further instances would then receive [1] and so on. 

However, because it is often necessary to change the order later (and therefore all indices), FSH uses [=] for a further entry for the current contact and [+] for the next contact.

ResearchStudy.contact is of type [ContactDetail](https://hl7.org/fhir/R4/metadatatypes.html#ContactDetail)which itself is composed of other data types. The deeper hierarchies are separated by a dot.

```
* contact[0].name = "Dr. Franziska Jauch"
* contact[=].telecom.system = #email
* contact[=].telecom.value = "fjauch@uniklinikum-ulm.de"
* contact[=].telecom.use = #work
* contact[+].name = "Wiktor Silberk"
* contact[=].telecom.system = #phone
* contact[=].telecom.value = "+49 1715 8264023"
* contact[=].telecom.use = #mobile
```

<a href="./assets/img/wt12-fsh-contacts.png"><img src="./assets/img/wt12-fsh-contacts.png" width="100"/></a>

## 9. Adding the condition to be studied (Codeable Concept)

The title of a study can contain important information about what the study is about. However, medical terminology is diverse and language-dependent. For clarity and machine processability, it is better to use a community-consensus vocabulary. In the field of medicine, SNOMED CT is a good international candidate.

FHIR has three basic ways of encoding elements. We have already seen FHIR [code](https://hl7.org/fhir/R4/datatypes.html#code). Here there is only the actual code, because the set from which it can be selected is implicitly fixed. FHIR [Coding](https://hl7.org/fhir/R4/datatypes.html#Coding), on the other hand, is like a code + a system from which the code comes. A FHIR [CodeableConcept](https://hl7.org/fhir/R4/datatypes.html#CodeableConcept) can do even more: here we can even use several annotations from Code+System.

This allows the FAIR requirement for multiple relevant metadata to be met, as other systems such as ICD-10 are often used in local systems, e.g. for diagnoses in hospitals. To ensure that there is no mixture and that the study is ultimately difficult to find, we specify both values.

```
* condition.text = "Cholera"
* condition.coding[0] = $icd-10#A00.0
* condition.coding[=].version = "2024"
* condition.coding[+] = $sct#240349003
* condition.coding[=].version = "http://snomed.info/sct/900000000000207008/version/20230731"
```

What you can also see here is the version of the referenced vocabulary. As the state of knowledge about diseases changes and new ones are added (Covid-19), this is good practice.

In addition, we use the alias feature of FSH, a definition of a constant as an abbreviation for long URIs that are used several times. Aliases are placed at the beginning of the document.

```
Alias: $icd-10 = http://hl7.org/fhir/sid/icd-10
Alias: $sct = http://snomed.info/sct
```

<a href="./assets/img/wt13-fsh-codeables.png"><img src="./assets/img/wt13-fsh-codeables.png" width="100"/></a>

## 10. Adding sponsor and PI (Reference to another named resource)

Finally, we want to add references to other FHIR resources. FHIR ResearchStudy sponsor refers to a FHIR Organization and principalInvestigator refers to a Practitioner or a PractitionerRole. Both are independent entities like ResearchStudy itself. Both can be references by other instance as well. However, they should only be created once.

In the case of principalInvestigator, you can see another peculiarity of FHIR: for some elements, several resource types are possible as values; the data modeler selects the most suitable one.

Referencing another FHIR resource instance is easy.

```
* sponsor = Reference(firetrial-sponsor)
* principalInvestigator = Reference(firetrial-pi)
```

We can also create the target resources in the same file.

```
Instance: firetrial-sponsor
InstanceOf: Organization
Usage: #example
* name = "Ulm University Hospital"

Instance: firetrial-pi
InstanceOf: Practitioner
Usage: #example
* name.text = "Prof. Dr. T. Ester"
```

FSH Online now generates three individual files, see on the far right.

<a href="./assets/img/wt14-fsh-references.png"><img src="./assets/img/wt14-fsh-references.png" width="100"/></a>

# Using the FHIR4FAIR Implementation Guide ResearchStudy-uv-f4f (Profile)
So far, only standard R4 resources have been used. Now a profile from the FHIR4FAIR Implementation Guide is to be used. ResearchStudy-uv-f4f is, as the name suggests, a profile from ResearchStudy. As already mentioned, profiles are, colloquially speaking, on the one hand, restrictions of values in order to obtain a certain data structure of higher quality and, on the other hand, extensions to map additional data.

First, it is declared that the instance created here should conform to the profile. This is evaluated during validation.

```
* meta.profile = "http://hl7.org/fhir/uv/fhir-for-fair/StructureDefinition/ResearchStudy-uv-f4f"
```

Meta.profile is a structure that is not defined in ResearchStudy itself, but which the [Meta](https://hl7.org/fhir/R4/resource.html#Meta) element inherits from its super-super-class [Resource](https://hl7.org/fhir/R4/resource.html#resource). 

A license is now to be added to the study. Licenses are one of the requirements of FAIR (R1.1). While a standard R4 ResearchStudy does not have the option of referring to a license, this has been implemented in the FHIR4FAIR IG as an extension [licenseCodeable](https://hl7.org/fhir/uv/fhir-for-fair/StructureDefinition-ResearchStudy-uv-f4f-definitions.html#ResearchStudy.extension:licenceCodeable). 

```
* extension[0].url = "http://hl7.org/fhir/uv/fhir-for-fair/StructureDefinition/licenceCodeable"
* extension[=].valueCodeableConcept = http://hl7.org/fhir/spdx-license#MIT "MIT License"
```

Now our study is under the MIT license (whatever that means).

<a href="./assets/img/wt15-fsh-license.png"><img src="./assets/img/wt15-fsh-license.png" width="100"/></a>

Download the complete example as [FSH](./assets/fsh/firetrial.fsh) or a [JSON](./assets/json/firetrial.json).

# Exercises

## Fine-tuning and tidying up

If we now want to validate our design, we have to give the validator a hint that this is now a FHIR4FAIR study. Although it already knows this from the information in meta.profile, it naturally lacks an idea of what the profile schema should look like.

* Open [Inferno](https://inferno.healthit.gov/validator/)
* Copy and paste the JSON code as before
* Click on "Advanced options"
* Below *Pick an Implementation Guide to validate against:*, enter FAIR. That will filter and 'hl7.fhir.uv.fhir-for-fair' will appear
* Below *Select a profile:*, select 'http://hl7.org/fhir/uv/fhir-for-fair/StructureDefinition/ResearchStudy-uv-f4f'
* Click on "Validate'

When we validate our current draft with , no errors occur, but there are some strange warnings.

<a href="./assets/img/wt16-inferno-warnings.png"><img src="./assets/img/wt16-inferno-warnings.png" width="100"/></a>

> No validation error issues found
> 
> Validation warnings:
> 
> 1. ResearchStudy: Constraint failed: dom-6: 'A resource should have narrative for robust management' (defined in
> http://hl7.org/fhir/StructureDefinition/DomainResource) (Best Practice Recommendation) on line 1. Jump to error.
> 2. ResearchStudy.status: ValueSet http://hl7.org/fhir/ValueSet/research-study-status|4.3.0 not found on line 9. Jump to error.
>
> Validation information:
>
> 3. ResearchStudy.identifier[0]: This element does not match any known slice defined in the profile http://hl7.org/fhir/uv/fhir-for-fair/StructureDefinition/ResearchStudy-uv-f4f|1.0.0 (this may not be a problem, but you should check that it's not intended to match a slice) on line 22. Jump to error.
> 4. ResearchStudy.condition[0]: Reference to experimental CodeSystem http://hl7.org/fhir/sid/icd-10|2019-covid-expanded on line 51. Jump to error.
> 5. ResearchStudy.extension[0].value.ofType(CodeableConcept): Reference to draft CodeSystem http://hl7.org/fhir/spdx-license|84728b7 on line 76. Jump to error.

<details>
<summary>Solution to 1.</summary>
The reason for the warning is that it is a Best Practice Recommendation to have an human-readable narrative in [DomainResource.text](https://hl7.org/fhir/R4/domainresource-definitions.html#DomainResource.text). DomainResource is the superclass of ResearchStudy, so the text element is inherited.

```
* text.status = #additional
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">[Epic information omitted for reasons of simplicity.]</div>"
```
</details>

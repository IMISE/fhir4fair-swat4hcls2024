<span class="logo"><img src="https://efmi.org/wp-content/uploads/2019/11/EFMI_Logo_new_wg-587x235.png" alt="EFMI Working Groups Logo" width="125"></span>
<span class="logo"><img src="https://www.nfdi4health.de/images/logo/nfdi4health.svg" alt="NFDI4Health Logo" width="125"></span>
<span class="logo"><img src="https://www.medizininformatik-initiative.de/themes/custom/mii/assets/img/Logo_MII_270px_Hoehe_de.png" alt="MII Logo" width="125"></span>

# Walk through

This walk-through is intended for interested parties who have not yet worked intensively with FSH.

## Dry run

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

## Creating an empty study

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

## Adding study status (code from a controlled vocabulary)

If we look at the specification of [ResearchStudy](https://hl7.org/fhir/R4/researchstudy.html#resource) in FHIR R4, we see that the cardinality of status is 1..1.

<a href="./assets/img/wt07-fhir-r4-researchstudy.png"><img src="./assets/img/wt07-fhir-r4-researchstudy.png" width="100"/></a>

We need to specify a value for status. The data type is code, i.e. it is a value from a predefined set. FHIR distinguishes between different degrees of strictness as to whether the value must actually be taken from the given values. This is the case with (Required). You can find out what the individual codes mean by clicking on ResearchStudyStatus.

```
* status = #in-review
```

All other elements are optional in the generic resource. Now no more errors are returned and the validation would also work.

<a href="./assets/img/wt08-rs-status.png"><img src="./assets/img/wt08-rs-status.png" width="100"/></a>

## Adding the study title (string)

The title of the study is a simple string.

```
* title = "FAIRness in FHIR"
```

## Adding a description (markdown)

The description of a study is of type markdown and is assigned in the same way, except that the receiving system must be able to handle markdown syntax.

```
* description = "A study assessing the **FAIRness** of FHIR artifacts."
```

## Adding a note (Annotation)

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

## Adding the start and end date/time of a study (Period)

Adding dates is very similar to strings, except that a [predefined format](https://www.hl7.org/fhir/datatypes-examples.html) must be adhered to. A FHIR [Period](https://www.hl7.org/fhir/datatypes.html#Period) has an optional start and end of type datetime.

Therefore, not only dates are possible. Our example study starts today in the morning and ends in December.

```
* period.start = "2024-02-26T09:00:00+01:00"
* period.end = "2024-12"
```

<a href="./assets/img/wt10-fsh-period.png"><img src="./assets/img/wt10-fsh-period.png" width="100"/></a>

## Adding the study id (Identifier)

An important criterion for findability in FAIR is a persistent identifier. Interventional clinical trials must be prospectively registered in a trial registry from which they receive an identifier. For example, we register our study in the international [ClinicalTrials.gov](https://clinicaltrials.gov/) register and receive the CT.gov number NCT05487991.

The fact that this is a universal business identifier is made clear with additional information.

```
* identifier[0].use = #official
* identifier[=].system = "https://clinicaltrials.gov"
* identifier[=].value = "NCT05487991"
```

<a href="./assets/img/wt11-fsh-identifier.png"><img src="./assets/img/wt11-fsh-identifier.png" width="100"/></a>

## Adding contacts (multiple values)

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

## Adding the condition to be studied (Codeable Concept)

The title of a study can contain important information about what the study is about. However, medical terminology is diverse and language-dependent. For clarity and machine processability, it is better to use a community-consensus vocabulary. In the field of medicine, SNOMED CT is a good international candidate.

FHIR has three basic ways of encoding elements. We have already seen FHIR code. Here there is only the actual code, because the set from which it can be selected is implicitly fixed. FHIR coding, on the other hand, is like a code + a system from which the code comes. A CodeableConcept can do even more: here we can even use several annotations from Code+System.

```
* identifier[0].use = #official
* identifier[=].system = "https://clinicaltrials.gov"
* identifier[=].value = "NCT05487991"
```

<a href="./assets/img/wt11-fsh-identifier.png"><img src="./assets/img/wt11-fsh-identifier.png" width="100"/></a>

## Adding sponsor and PI (Reference to another named resource)

## Aliases

## FHIR4FAIR

# Exercises

## Getting rid of the annoying validation warning

When we validate our current status with [Inferno](https://inferno.healthit.gov/validator/), no errors occur, but there is a strange warning:

> Warning: 

<details>
<summary>Solution</summary>

</details>
No problem while validating.



To make the last warning disappear







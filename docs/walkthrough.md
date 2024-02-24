<span class="logo"><img src="https://efmi.org/wp-content/uploads/2019/11/EFMI_Logo_new_wg-587x235.png" alt="EFMI Working Groups Logo" width="125"></span>
<span class="logo"><img src="https://www.nfdi4health.de/images/logo/nfdi4health.svg" alt="NFDI4Health Logo" width="125"></span>
<span class="logo"><img src="https://www.medizininformatik-initiative.de/themes/custom/mii/assets/img/Logo_MII_270px_Hoehe_de.png" alt="MII Logo" width="125"></span>

# Walk through

## Dry-run

This walk-through is intended for interested parties who have not yet worked intensively with FSH.

* Open [https://fshschool.org/FSHOnline/#/](https://fshschool.org/FSHOnline/#/).

<a href="./assets/img/wt01-fsh-online.png"><img src="./assets/img/wt01-fsh-online.png" width="100"/></a>

On the left-hand side you can see the editor for FSH, on the right-hand side the editor for FHIR-JSON. You can edit in both and then transfer the changes to the other side using "Convert to".

FSH Online provides useful templates.

* Go to "FSH Examples" and then to "Instances >> Instance Example".
* Click on "Clipboard", "Close" and paste the content in the left panel. Click "Convert to JSON".

<a href="./assets/img/wt02-fsh-example.png"><img src="./assets/img/wt02-fsh-example.png" width="100"/></a>

That's how it works basically. A new tab has appeared on the right-hand side; several FHIR resources can be created from one FSH file.

You can now validate the example to be sure.

* Copy the content of the right panel.
* Open [https://inferno.healthit.gov/validator/](https://inferno.healthit.gov/validator/).
* Paste the content and click "Validate".

There should be no errors, only some warnings.

## Creating an empty study

* Open [https://fshschool.org/FSHOnline/#/](https://fshschool.org/FSHOnline/#/) and delete everything possibly left in the FSH tab.
* Enter the code snippet below and substitude the name of the instance with your pref Press "Convert to JSON".

```
Instance: firetrial
InstanceOf: ResearchStudy
Description: "Example of a research study"
Usage: #example
```

It generates some JSON code, but there is obviously a mistake.

> error Element ResearchStudy.status has minimum cardinality 1 but occurs 0 time(s).
> Line: 1 - 4

The ResearchStudy has a mandatory field called status in FHIR and this is missing.

## Adding an element from a controlled vocabulary (study status)

If we look at the specification of [ResearchStudy](https://hl7.org/fhir/R4/researchstudy.html#resource) in FHIR R4, we see that the cardinality of status is 1..1.

We need to specify a value for status. The data type is code, i.e. it is a value from a predefined set. FHIR distinguishes between different degrees of strictness as to whether the value must actually be taken from the given values. This is the case with (Required). You can find out what the individual codes mean by clicking on ResearchStudyStatus.

```
* status = #in-review
```

All other elements are optional in the generic resource. Now no more errors are returned and the validation would also work. F

## Adding the study title

The title of the study is a simple string.

```
* title = "FAIRness in FHIR"
```

## Adding a description

The description of a study is of type markdown and is assigned in the same way, except that the receiving system must be able to handle markdown syntax.

```
* description = "A study assessing the **FAIRness** of FHIR artifacts."
```

## Adding a note

```
* note = "Study design is still unclear."
```

Although it was about text again, it didn't work this time. The data type of note is [Annotation](https://hl7.org/fhir/R4/datatypes.html#Annotation) and this is not a primitive data type.
An annotation can have an author and a creation date. We now want to dispense with this and only use the text element.

```
* note.text = "Study design is still unclear."
```

No problem while converting. 

## Adding the start and end date/time of a study

Adding dates
No problem while validating.



To make the last warning disappear







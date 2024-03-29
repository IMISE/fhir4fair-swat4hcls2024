<span class="logo"><img src="https://efmi.org/wp-content/uploads/2019/11/EFMI_Logo_new_wg-587x235.png" alt="EFMI Working Groups Logo" width="125"></span>
<span class="logo"><img src="https://www.nfdi4health.de/images/logo/nfdi4health.svg" alt="NFDI4Health Logo" width="125"></span>
<span class="logo"><img src="https://www.medizininformatik-initiative.de/themes/custom/mii/assets/img/Logo_MII_270px_Hoehe_de.png" alt="MII Logo" width="125"></span>

# Working with FHIR Shorthand
FSH is usually used for "profiling", which basically means restricting cardinalities, limiting codes to a certain set and adding more use case semantics to the very generic FHIR resources. It can also be used to creates instance that conform to a given specification and that is what we want to do in our limited setting.

## Creating FHIR instances with FSH
For the practical work in the tutorial, we recommend working with **FHIR Short Hand (FSH)**, a DSL that can be translated into FHIR and, unlike JSON or XML, has the advantage that there is a clearly legible instruction in every line. Some help will be found there.

* [FSH Cheat Sheet](https://build.fhir.org/ig/HL7/fhir-shorthand/FSHQuickReference.pdf) - providing a reference the most-used structures
* [FSH Specification](https://build.fhir.org/ig/HL7/fhir-shorthand/) - good for cracks, harder for neophytes
* [FSH Finder](https://fshschool.org/fsh-finder/) - list of projects using FSH, if you are looking for additional examples

FSH is stored in text files in real projects and translated into FHIR using a compiler ([SUSHI](https://fshschool.org/docs/sushi/)). It is also possible to return FHIR to FSH ([GoFSH](https://fshschool.org/docs/gofsh/)). Due to the more complex configuration of SUSHI, we use a web tool that provides the most important functions in a small GUI. FSH Online contains a range of FSH templates in the *FSH Examples* menu item that you can use to get started.

* **Important: [FSH Online](https://fshschool.org/FSHOnline/#/)**

Alternatively, FSH can also be written in the tool Simplifier. Here there are more options for translation, e.g. in FHIR-XML or as an HTML view, but no return path.

* **Important: [Simplifier FSH](https://simplifier.net/fsh)**

## Validating FHIR
Even if a resource can be translated from FSH to JSON without errors, problems are still possible that the compiler does not recognize. To ensure the conformity of a structure, it must be validated against the generic FHIR resource. There are various validators with different quality levels depending on the principle. Two of them can be called up as a web tool:

* **Important: [Inferno Validator](https://inferno.healthit.gov/validator/)**
* **Important: [Simplifier Validator](https://simplifier.net/validate)**

Simplifier can also validate against a profile deposited in the Simplifier registry:

* [Simplifier Validator with profiles for NFDI4Health Metadata Schema](https://simplifier.net/validate?scope=NFDI4Health-Metadata-Schema@current)
* [Simplifier Validator with profiles for MII Modul Research Studies](https://simplifier.net/validate?scope=de.medizininformatikinitiative.kerndatensatz.studie@1.0.0&amp;fhirVersion=R4)

## Advanced Tooling
There is a whole ecosystem of useful tools that make working with FSH and FHIR easier. However, **these will not be used in this tutorial**.

* https://confluence.hl7.org/display/FHIR/Profile+Tooling

### Visual Studio Code extensions
Extensions extend the functionality of [VS Code](https://code.visualstudio.com/), a popular programming IDE.

* [FSH Language Support for VS Code](https://marketplace.visualstudio.com/items?itemName=MITRE-Health.vscode-language-fsh) - syntax highlighting, autocomplete
* [codfsh](https://github.com/gematik/codfsh) - wraps SUSHI (FHIR Shorthand) and the HAPI Validator, providing comprehensive warning and error messages. It allows you to "run" your .fsh shorthand files to both generate FHIR .json files and validate them simultaneously.

### FHIR Servers (public)
* https://confluence.hl7.org/display/FHIR/Public+Test+Servers

### FHIR Servers (local deployment)
* [Use Firely Server with your Simplifier artifact](https://docs.fire.ly/projects/Simplifier/features/simplifierFirely-server.html) - runs a docker container with a FHIR server and all profile and examples already uploaded.

### Postman
Postman is a well-known API client that allows the create and send complex HTTP REST queries.

* [Your First Interactions with Your FHIR Server](https://fire.ly/blog/your-first-interactions-with-your-fhir-server/)
* [Accessing Firely Server with Postman](https://docs.fire.ly/projects/Firely-Server/en/latest/getting_started/postman_tutorial.html#postman-tutorial)

### ClinFHIR
[ClinFHIR](http://clinfhir.com/) is a portal of different tools for playing with FHIR or demonstration purposes. It includes a Patient Viewer, Scenario Builder, Logical Modeller, CodeSystem builder, Extension Definition builder and a Query Tool.

### FEvIR PlatMit freundlichen Grüßen
The [FEvIR Platform](https://fevir.net/) includes many Builder Tools to create FHIR® Resources without requiring expertise in FHIR® or JSON, and Converter Tools to convert structured data to FHIR® Resources.

# WEBUI-1142

## About / Synopsis

This project demonstrates how the **PDF preview** is not working when it is previewing a **PDF** file stored in a custom blob property (other than the OOTB blob properties like `file:content`, `files:files`, ...) in a version of **Web UI** greater than **3.0.18**.

It was generated with the following commands:
```
nuxeo b multi-module
nuxeo b contribution --type core
nuxeo b single-module --type web
nuxeo b docker
nuxeo b docker-compose
mvn package
```

## Requirements

Building requires the following software:

* git
* maven
* docker (only for **Option 1** below)
* docker-compose (only for **Option 1** below)

## Build

```
git clone ...
cd WEBUI-1142

mvn clean install
```

## Installation

### Option 1

```
docker-compose up ; docker-compose down -v
```

### Option 2

In a **Nuxeo** instance with **Nuxeo Web UI 3.0.19** installed:
```
nuxeoctl mp-install WEBUI-1142/WEBUI-1142-package/target/WEBUI-1142-package-1.0.19.zip
```

## How to use

### Initialize the document repository

```
chmod 750 ./init-repository.sh
./init-repository.sh
```

### Preview a PDF file stored in a custom blob property

In a browser, navigate to [http://localhost:8080/nuxeo/ui/#!/browse/default-domain/UserWorkspaces/Administrator/WEBUI-1142-1](http://localhost:8080/nuxeo/ui/#!/browse/default-domain/UserWorkspaces/Administrator/WEBUI-1142-1)

==> The **PDF preview** does not show.

## Support

**These features are not part of the Nuxeo Production platform, they are not supported**

These solutions are provided for inspiration and we encourage customers to use them as code samples and learning resources.

This is a moving project (no API maintenance, no deprecation process, etc.) If any of these solutions are found to be useful for the Nuxeo Platform in general, they will be integrated directly into platform, not maintained here.


## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

## About Nuxeo

Nuxeo Platform is an open source Content Services platform, written in Java. Data can be stored in both SQL & NoSQL databases.

The development of the Nuxeo Platform is mostly done by Nuxeo employees with an open development model.

The source code, documentation, roadmap, issue tracker, testing, benchmarks are all public.

Typically, Nuxeo users build different types of information management solutions for [document management](https://www.nuxeo.com/solutions/document-management/), [case management](https://www.nuxeo.com/solutions/case-management/), and [digital asset management](https://www.nuxeo.com/solutions/dam-digital-asset-management/), use cases. It uses schema-flexible metadata & content models that allows content to be repurposed to fulfill future use cases.

More information is available at [www.nuxeo.com](https://www.nuxeo.com).


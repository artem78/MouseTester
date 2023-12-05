To build zip-packages you should [install Apache Ant](https://ant.apache.org/manual/install.html) first.

Rename `build.properties.sample` file to `build.properties`. Open it and customize paths.

Next run command:

```
ant package -Darch="32-bit"
ant package -Darch="64-bit"
```

or with debug messages:

```
ant package -d -Darch="32-bit"
ant package -d -Darch="64-bit"
```

To build both 32 and 64-bit next commands may be used:

```
ant package_all
ant package_all -d
```
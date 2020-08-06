# Example calculator

This is an example of how to use [excel_to_code](https://github.com/tamc/excel_to_code) to drive an excel
model from a web interface and present its results. A more complex example is [The UK 2050 Calculator](https://github.com/decc/twenty-fifty).

The example was live coded as part of a workshop on 5 August 2020.

The goal of the example was to:

1. Show what is unique about the approach
2. Show what is possible
3. Point out some gotchas

Non-goals of the example were to:

1. Be pretty (that is where the bulk of the work in a real project would go)
2. Trap errors (that is where some work in a real project should go)
3. Support anything but the latest browsers (you may need to do that, but you may also want to choose a javascript framework to make it easy)

This example shows:

1. How to translate the excel model into code
2. How to use named references to make that translation less fragile
3. How to write a simple server to accept inputs, drive the model, and return outputs as json
4. How to use javascript to take inputs, send them to the server, and present the results
5. How to get arrays as outputs and plot them
6. How to get arrays as inputs, and create and handle generating multiple controls for them
7. How to make the browsers URL change, so the browsers back and forward buttons work, and so sets of inputs can be bookmarked and / or linked.

The example does not show (because we ran out of time):

8. How to have different views of the same model to show different results (e.g., different charts)


A note on chart frameworks:

You could draw charts from scratch in javascript, but you will probably choose to use a library in order to get a result quicker. There are a lot of libraries to choose from. The [classic UK 2050 Calculator](https://github.com/decc/twenty-fifty) used [d3js](https://d3js.org) which is free and gives a lot of low level control, but takes longer to get a result. The updated BEIS calculator is going to use [Highcharts](https://www.highcharts.com/blog/products/highcharts/) which must be paid for, but is quick to get going with, has nice defaults, and a lot of features. There are also many other options, some open source, some free, some paid for. The one in this example ([chartist](https://gionkunz.github.io/chartist-js/)) is open source and very easy to set up, but probably isn't fully featured enough for most situations.


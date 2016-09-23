## Building Documents

To build the docs locally, you first need to install Documenter.jl:

    julia -e 'Pkg.add("Documenter")'

then run the following from within this directory:

    julia make.jl

Then you can open the HTML documents in the `build` directory.

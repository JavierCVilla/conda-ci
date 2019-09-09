# [WIP] ROOT Continuous Integration with conda

Scripts based on [Enrico's repo](https://gitlab.cern.ch/eguiraud/test_conda_root)

Steps:

1. Build custom `clangdev` (currently hosted in my own [fork](https://github.com/JavierCvilla/clangdev-feedstock))

```
# Run this in the corresponding environment (docker image)
git clone https://github.com/JavierCvilla/clangdev-feedstock

# Checkout custom branch
git checkout root-ci

conda build -c conda-forge clangdev-feedstock/recipe --variants "{'clang_variant': ['master']}"
```


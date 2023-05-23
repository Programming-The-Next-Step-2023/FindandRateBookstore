# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/tests.html
# * https://testthat.r-lib.org/reference/test_package.html#special-files

install.packages("FindandRateBookstore")
install.packages("Rtools")

devtools::install_github("Programming-The-Next-Step-2023/FindandRateBookstore")

library(testthat)
library(FindandRateBookstore)

test_check("FindandRateBookstore")






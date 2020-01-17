library(stringi)
library(rebus)
postcode_pattern = "WRD %R% optional(WRD) %R%
  or(DGT %R% optional(DGT), DGT %R% WRD) %R%
  optional(SPC) %R%
  or(DGT, WRD) %R%
  WRD %R%
  optional(WRD) %R%
  END"
pat <- "(^(GIR ?0AA|[A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]([0-9ABEHMNPRV-Y])?)|[0-9][A-HJKPS-UW]) ?[0-9][ABD-HJLNP-UW-Z]{2})$)"
pat2 <- "^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$"

stri_extract_all(as.character(string), regex = pat2)
stri_extract_last(as.character(string), regex = postcode_pattern)



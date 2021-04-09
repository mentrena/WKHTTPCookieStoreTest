# WKHTTPCookieStoreTest
WKHTTPCookieStoreObserver bug showcase


## How to use

Clone the repository, open the project, run on iOS simulator and let it load the website.

The code uses both WKHTTPCookieStoreObserver to be notified of new cookies being added to the cookie store on the web view.
It also uses WKNavigationDelegate to get called when navigation finished loading a site, then manually inspect the cookies on the store.

On the console, I get:

```
*************************
Cookies in observer function:
GU_mvt_id
GU_geo_continent
*************************
*************************
Cookies in observer function:
GU_mvt_id
GU_geo_continent
*************************
*************************
Cookies in navigation delegate:
GU_mvt_id
bwid
bwid_withoutSameSiteForIncompatibleClients
vsid
consentUUID
GU_geo_continent
_sp_v1_uid
_sp_v1_data
_sp_v1_ss
_sp_v1_opt
_sp_v1_consent
_sp_v1_csv
_sp_v1_lt
*************************
```

The latter message prints many more cookies that were added to the store, but the observer function was not called for those.

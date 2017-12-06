when RULE_INIT {
       set static::FormBaseURL "/sp-ofba-form"
       set static::FormReturnURL "/sp-ofba-completed"
       set static::HeadAuthReq "X-FORMS_BASED_AUTH_REQUIRED"
       set static::HeadAuthRet "X-FORMS_BASED_AUTH_RETURN_URL"
       set static::HeadAuthSize "X-FORMS_BASED_AUTH_DIALOG_SIZE"
       set static::HeadAuthSizeVal "800x600"
       set static::ckname "MRHSession_SP"
       set static::Basic_Realm_Text "SharePoint Authentication"
    }

    when HTTP_REQUEST {
       set persist_cookie [HTTP::cookie value $static::ckname]
       set clientless_mode 0
       set form_mode 0
       # Identify User-Agents type
       if {[HTTP::header exists "X-FORMS_BASED_AUTH_ACCEPTED"] && (([HTTP::header "X-FORMS_BASED_AUTH_ACCEPTED"] equals "t") || ([HTTP::header "X-FORMS_BASED_AUTH_ACCEPTED"] equals "f"))} {
          set clientless_mode 0; set form_mode 1
       } else {
          switch -glob [string tolower [HTTP::header "User-Agent"]] {
             "*microsoft data access internet publishing provider*" -
             "*office protocol discovery*" -
             "*microsoft-webdav-miniredir*" -
             "*microsoft office*" -
             "*non-browser*" -
             "msoffice 12*" { set form_mode 1 }
             "*mozilla/4.0 (compatible; ms frontpage*" {
                if { [ string range [getfield [string tolower [HTTP::header "User-Agent"]] "MS FrontPage " 2] 0 1]  > 12 } {
                   set form_mode 1
                } else {
                   set clientless_mode 1
                }
             }
             "*mozilla*" -
             "*opera*" { set clientless_mode 0 }
             default { set clientless_mode 1
             }
          }
       }
    }

    when HTTP_RESPONSE {
       # Insert persistent cookie for html content type and private session
       if { [HTTP::header "Content-Type" ] contains "text/html" } {
          HTTP::cookie remove $static::ckname
          HTTP::cookie insert name $static::ckname value $apmsessionid path "/"
          HTTP::cookie expires $static::ckname 300 relative
          HTTP::cookie secure $static::ckname enable
       }
       # Insert session cookie if session was recovered from persistent cookie
       if { ([info exists "apmpersiststatus"]) && ($apmpersiststatus) } {
             HTTP::cookie insert name MRHSession value $persist_cookie path "/"
             HTTP::cookie secure MRHSession enable
       }
    }
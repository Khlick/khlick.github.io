@echo off
:: -------------------------------------
:: Shortcuts to develop, preview, and publish a site
:: Example for the _site.env file:
:: JKL_MYCONFIGS=--config _config.yml,_my/config.yml
:: JKL_WINSCPPATH=C:\PROGRA~1\WinSCP
:: JKL_LOCALSITEPATH=C:\Users\username\_git\myrepo\_site
:: JKL_REMOTESITEPATH=/home/username/public_html
:: JKL_REMOTEHOST=finesite.example.com
:: JKL_REMOTEUSER=myremoteuser
:: JKL_REMOTEEXCLUDES=admin/; anotherapp/; myimportantremotefile.html;
:: -------------------------------------
IF %2=="" ( SET "message='Update site'" ) ELSE ( SET "message=%2" )

if x%1==x goto :oops

REM parse _site.env
SET ROOT_DIR = %~dp0
for /f "tokens=1,2 delims==" %%i in (_site.env) do @set %%i=%%j

if x%1==xdev goto serve
if x%1==xdevnof goto nofuture
if x%1==xprod goto prod
if x%1==xpubd goto alldrafts
if x%1==xpublish goto write
echo Nothing to do.

:oops
echo usage: %~nx0 [dev^|devnof^|prod^|preview^|publish]
goto :eof

:serve
set JEKYLL_ENV=development
call bundle exec jekyll serve %JKL_MYCONFIGS% --watch --drafts --future
goto :done

:nofuture
set JEKYLL_ENV=development
call bundle exec jekyll serve %JKL_MYCONFIGS% --watch --drafts
goto :done

:prod
set JEKYLL_ENV=production
call bundle exec jekyll build %JKL_MYCONFIGS%
goto :done

:alldrafts
set JEKYLL_ENV=production
call bundle exec jekyll build %JKL_MYCONFIGS% --drafts
goto :done

:publish
ECHO "Publishing to "%GH_BRANCH%"."
call git checkout %BH_BRANCH%
call git add .
call git commit -m message
call git push -u origin %BH_BRANCH%
goto :done

:write
set JEKYLL_ENV=production
call bundle exec jekyll build %JKL_MYCONFIGS% --drafts
ECHO Building site...
goto publish

:done
echo Done.

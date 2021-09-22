dhall-to-bibtex: dhall-to-bibtex.dhall dhall-to-bibtex.in
	cp dhall-to-bibtex.in $@
	sed -i '/INSERT_HERE_DHALL/r dhall-to-bibtex.dhall' $@
	sed -i '/INSERT_HERE_DHALL/d' $@
	chmod +x $@

clean:
	rm dhall-to-bibtex

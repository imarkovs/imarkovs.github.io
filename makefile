undate-webpage:
	jemdoc index
	jemdoc publications
	jemdoc recent-publications
	jemdoc talks
	jemdoc software
	jemdoc positions
	jemdoc doctoral-school
	jemdoc doctoral-school-2013
	jemdoc book
push:
	git add --all
	git commit -m "update"
	git push

Artifacts(
	ID
	title
	description
	value
	year
	artistID
	collectionTitle
	collectionDate
)

Paintings(
	ID
	canvas
)

Sculptures(
	ID
	material
	color
)

Artists(
	ID
	name
	birthDate
	deathDate
	bio
)

Collections(
	title
	topic
)

Exhibitions(
	title
	topic
	room
	startDate
	endDate
)

Advertisements(
	exhibitionsTitle
	date
	mediumName
	cost
	duration
)

Media(
	name
	type
)

InfluencedBy(
	inflienceeID
	influencerID
)

ExhibitedAt(
	artifcatID
	exhibitionTitle
)
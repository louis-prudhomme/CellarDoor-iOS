import Foundation

// swiftlint:disable file_length

public extension GeoNamesQueryParameters {
    // swiftlint:disable:next type_body_length
    enum FeatureCode: String, Codable {
        /// Class A  - country, state, region,...
        /// first-order administrative division ; a primary administrative division of a country, such as a state in the United States
        case ADM1
        /// historical first-order administrative division ; a former first-order administrative division
        case ADM1H
        /// second-order administrative divisiona subdivision of a first-order administrative division
        case ADM2
        /// historical second-order administrative division ; a former second-order administrative division
        case ADM2H
        /// third-order administrative division ; a subdivision of a second-order administrative division
        case ADM3
        /// historical third-order administrative division ; a former third-order administrative division
        case ADM3H
        /// fourth-order administrative division ; a subdivision of a third-order administrative division
        case ADM4
        /// historical fourth-order administrative division ; a former fourth-order administrative division
        case ADM4H
        /// fifth-order administrative division ; a subdivision of a fourth-order administrative division
        case ADM5
        /// historical fifth-order administrative division ; a former fifth-order administrative division
        case ADM5H
        /// administrative division ; an administrative division of a country, undifferentiated as to administrative level
        case ADMD
        /// historical administrative division  ; a former administrative division of a political entity, undifferentiated as to administrative level
        case ADMDH
        /// leased area ; a tract of land leased to another country, usually for military installations
        case LTER
        /// political entity ;
        case PCL
        /// dependent political entity ;
        case PCLD
        /// freely associated state ;
        case PCLF
        /// historical political entity ; a former political entity
        case PCLH
        /// independent political entity ;
        case PCLI
        /// section of independent political entity ;
        case PCLIX
        /// semi-independent political entity ;
        case PCLS
        /// parish ; an ecclesiastical district
        case PRSH
        /// territory ;
        case TERR
        /// zone ;
        case ZN
        /// buffer zone ; a zone recognized as a buffer between two nations in which military presence is minimal or absent
        case ZNB
        /// Class H  - stream, lake, ...
        /// seaplane landing area ; a place on a waterbody where floatplanes land and take off
        case AIRS
        /// anchorage ; an area where vessels may anchor
        case ANCH
        /// bay ; a coastal indentation between two capes or headlands, larger than a cove but smaller than a gulf
        case BAY
        /// bays ; coastal indentations between two capes or headlands, larger than a cove but smaller than a gulf
        case BAYS
        /// bight(s) ; an open body of water forming a slight recession in a coastline
        case BGHT
        /// bank(s) ; an elevation, typically located on a shelf, over which the depth of water is relatively shallow but sufficient for most surface navigation
        case BNK
        /// stream bank ; a sloping margin of a stream channel which normally confines the stream to its channel on land
        case BNKR
        /// section of bank ;
        case BNKX
        /// bog(s) ; a wetland characterized by peat forming sphagnum moss, sedge, and other acid-water plants
        case BOG
        /// icecap ; a dome-shaped mass of glacial ice covering an area of mountain summits or other high lands; smaller than an ice sheet
        case CAPG
        /// channel ; the deepest part of a stream, bay, lagoon, or strait, through which the main current flows
        case CHN
        /// lake channel(s) ; that part of a lake having water deep enough for navigation between islands, shoals, etc.
        case CHNL
        /// marine channel ; that part of a body of water deep enough for navigation through an area otherwise not suitable
        case CHNM
        /// navigation channel ; a buoyed channel of sufficient depth for the safe navigation of vessels
        case CHNN
        /// confluence ; a place where two or more streams or intermittent streams flow together
        case CNFL
        /// canal ; an artificial watercourse
        case CNL
        /// aqueduct ; a conduit used to carry water
        case CNLA
        /// canal bend ; a conspicuously curved or bent section of a canal
        case CNLB
        /// drainage canal ; an artificial waterway carrying water away from a wetland or from drainage ditches
        case CNLD
        /// irrigation canal ; a canal which serves as a main conduit for irrigation water
        case CNLI
        /// navigation canal(s) ; a watercourse constructed for navigation of vessels
        case CNLN
        /// abandoned canal ;
        case CNLQ
        /// underground irrigation canal(s) ; a gently inclined underground tunnel bringing water for irrigation from aquifers
        case CNLSB
        /// section of canal ;
        case CNLX
        /// cove(s) ; a small coastal indentation, smaller than a bay
        case COVE
        /// tidal creek(s) ; a meandering channel in a coastal wetland subject to bi-directional tidal currents
        case CRKT
        /// current ; a horizontal flow of water in a given direction with uniform velocity
        case CRNT
        /// cutoff ; a channel formed as a result of a stream cutting through a meander neck
        case CUTF
        /// dock(s) ; a waterway between two piers, or cut into the land for the berthing of ships
        case DCK
        /// docking basin ; a part of a harbor where ships dock
        case DCKB
        /// icecap dome ; a comparatively elevated area on an icecap
        case DOMG
        /// icecap depression ; a comparatively depressed area on an icecap
        case DPRG
        /// ditch ; a small artificial watercourse dug for draining or irrigating the land
        case DTCH
        /// drainage ditch ; a ditch which serves to drain the land
        case DTCHD
        /// irrigation ditch ; a ditch which serves to distribute irrigation water
        case DTCHI
        /// ditch mouth(s) ; an area where a drainage ditch enters a lagoon, lake or bay
        case DTCHM
        /// estuary ; a funnel-shaped stream mouth or embayment where fresh water mixes with sea water under tidal influences
        case ESTY
        /// fishing area ; a fishing ground, bank or area where fishermen go to catch fish
        case FISH
        /// fjord ; a long, narrow, steep-walled, deep-water arm of the sea at high latitudes, usually along mountainous coasts
        case FJD
        /// fjords ; long, narrow, steep-walled, deep-water arms of the sea at high latitudes, usually along mountainous coasts
        case FJDS
        /// waterfall(s) ; a perpendicular or very steep descent of the water of a stream
        case FLLS
        /// section of waterfall(s) ;
        case FLLSX
        /// mud flat(s) ; a relatively level area of mud either between high and low tide lines, or subject to flooding
        case FLTM
        /// tidal flat(s) ; a large flat area of mud or sand attached to the shore and alternately covered and uncovered by the tide
        case FLTT
        /// glacier(s) ; a mass of ice, usually at high latitudes or high elevations, with sufficient thickness to flow away from the source area in lobes, tongues, or masses
        case GLCR
        /// gulf ; a large recess in the coastline, larger than a bay
        case GULF
        /// geyser ; a type of hot spring with intermittent eruptions of jets of hot water and steam
        case GYSR
        /// harbor(s) ; a haven or space of deep water so sheltered by the adjacent land as to afford a safe anchorage for ships
        case HBR
        /// section of harbor ;
        case HBRX
        /// inlet ; a narrow waterway extending into the land, or connecting a bay or lagoon with a larger body of water
        case INLT
        /// former inlet ; an inlet which has been filled in, or blocked by deposits
        case INLTQ
        /// lake bed(s) ; a dried up or drained area of a former lake
        case LBED
        /// lagoon ; a shallow coastal waterbody, completely or partly separated from a larger body of water by a barrier island, coral reef or other depositional feature
        case LGN
        /// lagoons ; shallow coastal waterbodies, completely or partly separated from a larger body of water by a barrier island, coral reef or other depositional feature
        case LGNS
        /// section of lagoon ;
        case LGNX
        /// lake ; a large inland body of standing water
        case LK
        /// crater lake ; a lake in a crater or caldera
        case LKC
        /// intermittent lake ;
        case LKI
        /// salt lake ; an inland body of salt water with no outlet
        case LKN
        /// intermittent salt lake ;
        case LKNI
        /// oxbow lake ; a crescent-shaped lake commonly found adjacent to meandering streams
        case LKO
        /// intermittent oxbow lake ;
        case LKOI
        /// lakes ; large inland bodies of standing water
        case LKS
        /// underground lake ; a standing body of water in a cave
        case LKSB
        /// crater lakes ; lakes in a crater or caldera
        case LKSC
        /// intermittent lakes ;
        case LKSI
        /// salt lakes ; inland bodies of salt water with no outlet
        case LKSN
        /// intermittent salt lakes ;
        case LKSNI
        /// section of lake ;
        case LKX
        /// salt evaporation ponds ; diked salt ponds used in the production of solar evaporated salt
        case MFGN
        /// mangrove swamp ; a tropical tidal mud flat characterized by mangrove vegetation
        case MGV
        /// moor(s) ; an area of open ground overlaid with wet peaty soils
        case MOOR
        /// marsh(es) ; a wetland dominated by grass-like vegetation
        case MRSH
        /// salt marsh ; a flat area, subject to periodic salt water inundation, dominated by grassy salt-tolerant plants
        case MRSHN
        /// narrows ; a navigable narrow part of a bay, strait, river, etc.
        case NRWS
        /// ocean ; one of the major divisions of the vast expanse of salt water covering part of the earth
        case OCN
        /// overfalls ; an area of breaking waves caused by the meeting of currents or by waves moving against the current
        case OVF
        /// pond ; a small standing waterbody
        case PND
        /// intermittent pond ;
        case PNDI
        /// salt pond ; a small standing body of salt water often in a marsh or swamp, usually along a seacoast
        case PNDN
        /// intermittent salt pond(s) ;
        case PNDNI
        /// ponds ; small standing waterbodies
        case PNDS
        /// fishponds ; ponds or enclosures in which fish are kept or raised
        case PNDSF
        /// intermittent ponds ;
        case PNDSI
        /// salt ponds ; small standing bodies of salt water often in a marsh or swamp, usually along a seacoast
        case PNDSN
        /// pool(s) ; a small and comparatively still, deep part of a larger body of water such as a stream or harbor; or a small body of standing water
        case POOL
        /// intermittent pool ;
        case POOLI
        /// reach ; a straight section of a navigable stream or channel between two bends
        case RCH
        /// icecap ridge ; a linear elevation on an icecap
        case RDGG
        /// roadstead ; an open anchorage affording less protection than a harbor
        case RDST
        /// reef(s) ; a surface-navigation hazard composed of consolidated material
        case RF
        /// coral reef(s) ; a surface-navigation hazard composed of coral
        case RFC
        /// section of reef ;
        case RFX
        /// rapids ; a turbulent section of a stream associated with a steep, irregular stream bed
        case RPDS
        /// reservoir(s) ; an artificial pond or lake
        case RSV
        /// intermittent reservoir ;
        case RSVI
        /// water tank ; a contained pool or tank of water at, below, or above ground level
        case RSVT
        /// ravine(s) ; a small, narrow, deep, steep-sided stream channel, smaller than a gorge
        case RVN
        /// sabkha(s) ; a salt flat or salt encrusted plain subject to periodic inundation from flooding or high tides
        case SBKH
        /// sound ; a long arm of the sea forming a channel between the mainland and an island or islands; or connecting two larger bodies of water
        case SD
        /// sea ; a large body of salt water more or less confined by continuous land or chains of islands forming a subdivision of an ocean
        case SEA
        /// shoal(s) ; a surface-navigation hazard composed of unconsolidated material
        case SHOL
        /// sill ; the low part of an underwater gap or saddle separating basins, including a similar feature at the mouth of a fjord
        case SILL
        /// spring(s) ; a place where ground water flows naturally out of the ground
        case SPNG
        /// sulphur spring(s) ; a place where sulphur ground water flows naturally out of the ground
        case SPNS
        /// hot spring(s) ; a place where hot ground water flows naturally out of the ground
        case SPNT
        /// stream ; a body of running water moving to a lower level in a channel on land
        case STM
        /// anabranch ; a diverging branch flowing out of a main stream and rejoining it downstream
        case STMA
        /// stream bend ; a conspicuously curved or bent segment of a stream
        case STMB
        /// canalized stream ; a stream that has been substantially ditched, diked, or straightened
        case STMC
        /// distributary(-ies) ; a branch which flows away from the main stream, as in a delta or irrigation canal
        case STMD
        /// headwaters ; the source and upper part of a stream, including the upper drainage basin
        case STMH
        /// intermittent stream ;
        case STMI
        /// section of intermittent stream ;
        case STMIX
        /// stream mouth(s) ; a place where a stream discharges into a lagoon, lake, or the sea
        case STMM
        /// abandoned watercourse ; a former stream or distributary no longer carrying flowing water, but still evident due to lakes, wetland, topographic or vegetation patterns
        case STMQ
        /// streams ; bodies of running water moving to a lower level in a channel on land
        case STMS
        /// lost river ; a surface stream that disappears into an underground channel, or dries up in an arid area
        case STMSB
        /// section of stream ;
        case STMX
        /// strait ; a relatively narrow waterway, usually narrower and less extensive than a sound, connecting two larger bodies of water
        case STRT
        /// swamp ; a wetland dominated by tree vegetation
        case SWMP
        /// irrigation system ; a network of ditches and one or more of the following elements: water supply, reservoir, canal, pump, well, drain, etc.
        case SYSI
        /// canal tunnel ; a tunnel through which a canal passes
        case TNLC
        /// wadi ; a valley or ravine, bounded by relatively steep banks, which in the rainy season becomes a watercourse; found primarily in North Africa and the Middle East
        case WAD
        /// wadi bend ; a conspicuously curved or bent segment of a wadi
        case WADB
        /// wadi junction ; a place where two or more wadies join
        case WADJ
        /// wadi mouth ; the lower terminus of a wadi where it widens into an adjoining floodplain, depression, or waterbody
        case WADM
        /// wadies ; valleys or ravines, bounded by relatively steep banks, which in the rainy season become watercourses; found primarily in North Africa and the Middle East
        case WADS
        /// section of wadi ;
        case WADX
        /// whirlpool ; a turbulent, rotating movement of water in a stream
        case WHRL
        /// well ; a cylindrical hole, pit, or tunnel drilled or dug down to a depth from which water, oil, or gas can be pumped or brought to the surface
        case WLL
        /// abandoned well ;
        case WLLQ
        /// wells ; cylindrical holes, pits, or tunnels drilled or dug down to a depth from which water, oil, or gas can be pumped or brought to the surface
        case WLLS
        /// wetland ; an area subject to inundation, usually characterized by bog, marsh, or swamp vegetation
        case WTLD
        /// intermittent wetland ;
        case WTLDI
        /// watercourse ; a natural, well-defined channel produced by flowing water, or an artificial channel designed to carry flowing water
        case WTRC
        /// waterhole(s) ; a natural hole, hollow, or small depression that contains water, used by man and animals, especially in arid areas
        case WTRH
        /// Class L  - parks,area, ...
        /// agricultural colony ; a tract of land set aside for agricultural settlement
        case AGRC
        /// amusement park ; Amusement Park are theme parks, adventure parks offering entertainment, similar to funfairs but with a fix location
        case AMUS
        /// area ; a tract of land without homogeneous character or boundaries
        case AREA
        /// drainage basin ; an area drained by a stream
        case BSND
        /// petroleum basin ; an area underlain by an oil-rich structural basin
        case BSNP
        /// battlefield ; a site of a land battle of historical importance
        case BTL
        /// clearing ; an area in a forest with trees removed
        case CLG
        /// common ; a park or pasture for community use
        case CMN
        /// concession area ; a lease of land by a government for economic development, e.g., mining, forestry
        case CNS
        /// coalfield ; a region in which coal deposits of possible economic value occur
        case COLF
        /// continent ; continent: Europe, Africa, Asia, North America, South America, Oceania, Antarctica
        case CONT
        /// coast ; a zone of variable width straddling the shoreline
        case CST
        /// business center ; a place where a number of businesses are located
        case CTRB
        /// housing development ; a tract of land on which many houses of similar design are built according to a development plan
        case DEVH
        /// field(s) ; an open as opposed to wooded area
        case FLD
        /// irrigated field(s) ; a tract of level or terraced land which is irrigated
        case FLDI
        /// gasfield ; an area containing a subterranean store of natural gas of economic value
        case GASF
        /// grazing area ; an area of grasses and shrubs used for grazing
        case GRAZ
        /// gravel area ; an area covered with gravel
        case GVL
        /// industrial area ; an area characterized by industrial activity
        case INDS
        /// arctic land ; a tract of land in the Arctic
        case LAND
        /// locality ; a minor area or place of unspecified or mixed character and indefinite boundaries
        case LCTY
        /// military base ; a place used by an army or other armed service for storing arms and supplies, and for accommodating and training troops, a base from which operations can be initiated
        case MILB
        /// mining area ; an area of mine sites where minerals and ores are extracted
        case MNA
        /// maneuver area ; a tract of land where military field exercises are carried out
        case MVA
        /// naval base ; an area used to store supplies, provide barracks for troops and naval personnel, a port for naval vessels, and from which operations are initiated
        case NVB
        /// oasis(-es) ; an area in a desert made productive by the availability of water
        case OAS
        /// oilfield ; an area containing a subterranean store of petroleum of economic value
        case OILF
        /// peat cutting area ; an area where peat is harvested
        case PEAT
        /// park ; an area, often of forested land, maintained as a place of beauty, or for recreation
        case PRK
        /// port ; a place provided with terminal and transfer facilities for loading and discharging waterborne cargo or passengers, usually located in a harbor
        case PRT
        /// quicksand ; an area where loose sand with water moving through it may become unstable when heavy objects are placed at the surface, causing them to sink
        case QCKS
        /// reserve ; a tract of public land reserved for future use or restricted as to use
        case RES
        /// agricultural reserve ; a tract of land reserved for agricultural reclamation and/or development
        case RESA
        /// forest reserve ; a forested area set aside for preservation or controlled use
        case RESF
        /// hunting reserve ; a tract of land used primarily for hunting
        case RESH
        /// nature reserve ; an area reserved for the maintenance of a natural habitat
        case RESN
        /// palm tree reserve ; an area of palm trees where use is controlled
        case RESP
        /// reservation ; a tract of land set aside for aboriginal, tribal, or native populations
        case RESV
        /// wildlife reserve ; a tract of public land reserved for the preservation of wildlife
        case RESW
        /// region ; an area distinguished by one or more observable physical or cultural characteristics
        case RGN
        /// economic region ; a region of a country established for economic development or for statistical purposes
        case RGNE
        /// historical region ; a former historic area distinguished by one or more observable physical or cultural characteristics
        case RGNH
        /// lake region ; a tract of land distinguished by numerous lakes
        case RGNL
        /// artillery range ; a tract of land used for artillery firing practice
        case RNGA
        /// salt area ; a shallow basin or flat where salt accumulates after periodic inundation
        case SALT
        /// snowfield ; an area of permanent snow and ice forming the accumulation area of a glacier
        case SNOW
        /// tribal area ; a tract of land used by nomadic or other tribes
        case TRB
        /// Class P  - city, village,...
        /// populated place ; a city, town, village, or other agglomeration of buildings where people live and work
        case PPL
        /// seat of a first-order administrative division ; seat of a first-order administrative division (PPLC takes precedence over PPLA)
        case PPLA
        /// seat of a second-order administrative division ;
        case PPLA2
        /// seat of a third-order administrative division ;
        case PPLA3
        /// seat of a fourth-order administrative division ;
        case PPLA4
        /// seat of a fifth-order administrative division ;
        case PPLA5
        /// capital of a political entity ;
        case PPLC
        /// historical capital of a political entity ; a former capital of a political entity
        case PPLCH
        /// farm village ; a populated place where the population is largely engaged in agricultural activities
        case PPLF
        /// seat of government of a political entity ;
        case PPLG
        /// historical populated place ; a populated place that no longer exists
        case PPLH
        /// populated locality ; an area similar to a locality but with a small group of dwellings or other buildings
        case PPLL
        /// abandoned populated place ;
        case PPLQ
        /// religious populated place ; a populated place whose population is largely engaged in religious occupations
        case PPLR
        /// populated places ; cities, towns, villages, or other agglomerations of buildings where people live and work
        case PPLS
        /// destroyed populated place ; a village, town or city destroyed by a natural disaster, or by war
        case PPLW
        /// section of populated place ;
        case PPLX
        /// israeli settlement ;
        case STLMT
        /// Class R  - road, railroad
        /// causeway ; a raised roadway across wet ground or shallow water
        case CSWY
        /// oil pipeline ; a pipeline used for transporting oil
        case OILP
        /// promenade ; a place for public walking, usually along a beach front
        case PRMN
        /// portage ; a place where boats, goods, etc., are carried overland between navigable waters
        case PTGE
        /// road ; an open way with improved surface for transportation of animals, people and vehicles
        case RD
        /// ancient road ; the remains of a road used by ancient cultures
        case RDA
        /// road bend ; a conspicuously curved or bent section of a road
        case RDB
        /// road cut ; an excavation cut through a hill or ridge for a road
        case RDCUT
        /// road junction ; a place where two or more roads join
        case RDJCT
        /// railroad junction ; a place where two or more railroad tracks join
        case RJCT
        /// railroad ; a permanent twin steel-rail track on which freight and passenger cars move long distances
        case RR
        /// abandoned railroad ;
        case RRQ
        /// caravan route ; the route taken by caravans
        case RTE
        /// railroad yard ; a system of tracks used for the making up of trains, and switching and storing freight cars
        case RYD
        /// street ; a paved urban thoroughfare
        case ST
        /// stock route ; a route taken by livestock herds
        case STKR
        /// tunnel ; a subterranean passageway for transportation
        case TNL
        /// natural tunnel ; a cave that is open at both ends
        case TNLN
        /// road tunnel ; a tunnel through which a road passes
        case TNLRD
        /// railroad tunnel ; a tunnel through which a railroad passes
        case TNLRR
        /// tunnels ; subterranean passageways for transportation
        case TNLS
        /// trail ; a path, track, or route used by pedestrians, animals, or off-road vehicles
        case TRL
        /// Class S  - spot, building, farm
        /// administrative facility ; a government building
        case ADMF
        /// agricultural facility ; a building and/or tract of land used for improving agriculture
        case AGRF
        /// airbase ; an area used to store supplies, provide barracks for air force personnel, hangars and runways for aircraft, and from which operations are initiated
        case AIRB
        /// airfield ; a place on land where aircraft land and take off; no facilities provided for the commercial handling of passengers and cargo
        case AIRF
        /// heliport ; a place where helicopters land and take off
        case AIRH
        /// airport ; a place where aircraft regularly land and take off, with runways, navigational aids, and major facilities for the commercial handling of passengers and cargo
        case AIRP
        /// abandoned airfield ;
        case AIRQ
        /// terminal ; airport facilities for the handling of freight and passengers
        case AIRT
        /// amphitheater ; an oval or circular structure with rising tiers of seats about a stage or open space
        case AMTH
        /// archaeological/prehistoric site ; a place where archeological remains, old structures, or cultural artifacts are located
        case ANS
        /// aquaculture facility ; facility or area for the cultivation of aquatic animals and plants, especially fish, shellfish, and seaweed, in natural or controlled marine or freshwater environments; underwater agriculture
        case AQC
        /// arch ; a natural or man-made structure in the form of an arch
        case ARCH
        /// archive ; a place or institution where documents are preserved
        case ARCHV
        /// piece of art ; a piece of art, like a sculpture, painting. In contrast to monument (MNMT) it is not commemorative.
        case ART
        /// astronomical station ; a point on the earth whose position has been determined by observations of celestial bodies
        case ASTR
        /// asylum ; a facility where the insane are cared for and protected
        case ASYL
        /// athletic field ; a tract of land used for playing team sports, and athletic track and field events
        case ATHF
        /// automatic teller machine ; An unattended electronic machine in a public place, connected to a data system and related equipment and activated by a bank customer to obtain cash withdrawals and other banking services.
        case ATM
        /// bank ; A business establishment in which money is kept for saving or commercial purposes or is invested, supplied for loans, or exchanged.
        case BANK
        /// beacon ; a fixed artificial navigation mark
        case BCN
        /// bridge ; a structure erected across an obstacle such as a stream, road, etc., in order to carry roads, railroads, and pedestrians across
        case BDG
        /// ruined bridge ; a destroyed or decayed bridge which is no longer functional
        case BDGQ
        /// apartment building ; a building containing several individual apartments
        case BLDA
        /// building(s) ; a structure built for permanent use, as a house, factory, etc.
        case BLDG
        /// office building ; commercial building where business and/or services are conducted
        case BLDO
        /// boundary marker ; a fixture marking a point along a boundary
        case BP
        /// barracks ; a building for lodging military personnel
        case BRKS
        /// breakwater ; a structure erected to break the force of waves at the entrance to a harbor or port
        case BRKW
        /// baling station ; a facility for baling agricultural products
        case BSTN
        /// boatyard ; a waterside facility for servicing, repairing, and building small vessels
        case BTYD
        /// burial cave(s) ; a cave used for human burials
        case BUR
        /// bus station ; a facility comprising ticket office, platforms, etc. for loading and unloading passengers
        case BUSTN
        /// bus stop ; a place lacking station facilities
        case BUSTP
        /// cairn ; a heap of stones erected as a landmark or for other purposes
        case CARN
        /// cave(s) ; an underground passageway or chamber, or cavity on the side of a cliff
        case CAVE
        /// church ; a building for public Christian worship
        case CH
        /// camp(s) ; a site occupied by tents, huts, or other shelters for temporary use
        case CMP
        /// logging camp ; a camp used by loggers
        case CMPL
        /// labor camp ; a camp used by migrant or temporary laborers
        case CMPLA
        /// mining camp ; a camp used by miners
        case CMPMN
        /// oil camp ; a camp used by oilfield workers
        case CMPO
        /// abandoned camp ;
        case CMPQ
        /// refugee camp ; a camp used by refugees
        case CMPRF
        /// cemetery ; a burial place or ground
        case CMTY
        /// communication center ; a facility, including buildings, antennae, towers and electronic equipment for receiving and transmitting information
        case COMC
        /// corral(s) ; a pen or enclosure for confining or capturing animals
        case CRRL
        /// casino ; a building used for entertainment, especially gambling
        case CSNO
        /// castle ; a large fortified building or set of buildings
        case CSTL
        /// customs house ; a building in a port where customs and duties are paid, and where vessels are entered and cleared
        case CSTM
        /// courthouse ; a building in which courts of law are held
        case CTHSE
        /// atomic center ; a facility where atomic research is carried out
        case CTRA
        /// community center ; a facility for community recreation and other activities
        case CTRCM
        /// facility center ; a place where more than one facility is situated
        case CTRF
        /// medical center ; a complex of health care buildings including two or more of the following: hospital, medical school, clinic, pharmacy, doctor's offices, etc.
        case CTRM
        /// religious center ; a facility where more than one religious activity is carried out, e.g., retreat, school, monastery, worship
        case CTRR
        /// space center ; a facility for launching, tracking, or controlling satellites and space vehicles
        case CTRS
        /// convent ; a building where a community of nuns lives in seclusion
        case CVNT
        /// dam ; a barrier constructed across a stream to impound water
        case DAM
        /// ruined dam ; a destroyed or decayed dam which is no longer functional
        case DAMQ
        /// sub-surface dam ; a dam put down to bedrock in a sand river
        case DAMSB
        /// dairy ; a facility for the processing, sale and distribution of milk or milk products
        case DARY
        /// dry dock ; a dock providing support for a vessel, and means for removing the water so that the bottom of the vessel can be exposed
        case DCKD
        /// dockyard ; a facility for servicing, building, or repairing ships
        case DCKY
        /// dike ; an earth or stone embankment usually constructed for flood or stream control
        case DIKE
        /// diplomatic facility ; office, residence, or facility of a foreign government, which may include an embassy, consulate, chancery, office of charge d'affaires, or other diplomatic, economic, military, or cultural mission
        case DIP
        /// fuel depot ; an area where fuel is stored
        case DPOF
        /// estate(s) ; a large commercialized agricultural landholding with associated buildings and other facilities
        case EST
        /// oil palm plantation ; an estate specializing in the cultivation of oil palm trees
        case ESTO
        /// rubber plantation ; an estate which specializes in growing and tapping rubber trees
        case ESTR
        /// sugar plantation ; an estate that specializes in growing sugar cane
        case ESTSG
        /// tea plantation ; an estate which specializes in growing tea bushes
        case ESTT
        /// section of estate ;
        case ESTX
        /// facility ; a building or buildings housing a center, institute, foundation, hospital, prison, mission, courthouse, etc.
        case FCL
        /// foundry ; a building or works where metal casting is carried out
        case FNDY
        /// farm ; a tract of land with associated buildings devoted to agriculture
        case FRM
        /// abandoned farm ;
        case FRMQ
        /// farms ; tracts of land with associated buildings devoted to agriculture
        case FRMS
        /// farmstead ; the buildings and adjacent service areas of a farm
        case FRMT
        /// fort ; a defensive structure or earthworks
        case FT
        /// ferry ; a boat or other floating conveyance and terminal facilities regularly used to transport people and vehicles across a waterbody
        case FY
        /// ferry terminal ; a place where ferries pick-up and discharge passengers, vehicles and or cargo
        case FYT
        /// gate ; a controlled access entrance or exit
        case GATE
        /// garden(s) ; an enclosure for displaying selected plant or animal life
        case GDN
        /// ghat ; a set of steps leading to a river, which are of religious significance, and at their base is usually a platform for bathing
        case GHAT
        /// guest house ; a house used to provide lodging for paying guests
        case GHSE
        /// gas-oil separator plant ; a facility for separating gas from oil
        case GOSP
        /// local government office ; a facility housing local governmental offices, usually a city, town, or village hall
        case GOVL
        /// grave ; a burial site
        case GRVE
        /// hermitage ; a secluded residence, usually for religious sects
        case HERM
        /// halting place ; a place where caravans stop for rest
        case HLT
        /// homestead ; a residence, owner's or manager's, on a sheep or cattle station, woolshed, outcamp, or Aboriginal outstation, specific to Australia and New Zealand
        case HMSD
        /// house(s) ; a building used as a human habitation
        case HSE
        /// country house ; a large house, mansion, or chateau, on a large estate
        case HSEC
        /// hospital ; a building in which sick or injured, especially those confined to bed, are medically treated
        case HSP
        /// clinic ; a medical facility associated with a hospital for outpatients
        case HSPC
        /// dispensary ; a building where medical or dental aid is dispensed
        case HSPD
        /// leprosarium ; an asylum or hospital for lepers
        case HSPL
        /// historical site ; a place of historical importance
        case HSTS
        /// hotel ; a building providing lodging and/or meals for the public
        case HTL
        /// hut ; a small primitive house
        case HUT
        /// huts ; small primitive houses
        case HUTS
        /// military installation ; a facility for use of and control by armed forces
        case INSM
        /// research institute ; a facility where research is carried out
        case ITTR
        /// jetty ; a structure built out into the water at a river mouth or harbor entrance to regulate currents and silting
        case JTY
        /// landing ; a place where boats receive or discharge passengers and freight, but lacking most port facilities
        case LDNG
        /// leper colony ; a settled area inhabited by lepers in relative isolation
        case LEPC
        /// library ; A place in which information resources such as books are kept for reading, reference, or lending.
        case LIBR
        /// landfill ; a place for trash and garbage disposal in which the waste is buried between layers of earth to build up low-lying land
        case LNDF
        /// lock(s) ; a basin in a waterway with gates at each end by means of which vessels are passed from one water level to another
        case LOCK
        /// lighthouse ; a distinctive structure exhibiting a major navigation light
        case LTHSE
        /// mall ; A large, often enclosed shopping complex containing various stores, businesses, and restaurants usually accessible by common passageways.
        case MALL
        /// marina ; a harbor facility for small boats, yachts, etc.
        case MAR
        /// factory ; one or more buildings where goods are manufactured, processed or fabricated
        case MFG
        /// brewery ; one or more buildings where beer is brewed
        case MFGB
        /// cannery ; a building where food items are canned
        case MFGC
        /// copper works ; a facility for processing copper ore
        case MFGCU
        /// limekiln ; a furnace in which limestone is reduced to lime
        case MFGLM
        /// munitions plant ; a factory where ammunition is made
        case MFGM
        /// phosphate works ; a facility for producing fertilizer
        case MFGPH
        /// abandoned factory ;
        case MFGQ
        /// sugar refinery ; a facility for converting raw sugar into refined sugar
        case MFGSG
        /// market ; a place where goods are bought and sold at regular intervals
        case MKT
        /// mill(s) ; a building housing machines for transforming, shaping, finishing, grinding, or extracting products
        case ML
        /// ore treatment plant ; a facility for improving the metal content of ore by concentration
        case MLM
        /// olive oil mill ; a mill where oil is extracted from olives
        case MLO
        /// sugar mill ; a facility where sugar cane is processed into raw sugar
        case MLSG
        /// former sugar mill ; a sugar mill no longer used as a sugar mill
        case MLSGQ
        /// sawmill ; a mill where logs or lumber are sawn to specified shapes and sizes
        case MLSW
        /// windmill ; a mill or water pump powered by wind
        case MLWND
        /// water mill ; a mill powered by running water
        case MLWTR
        /// mine(s) ; a site where mineral ores are extracted from the ground by excavating surface pits and subterranean passages
        case MN
        /// gold mine(s) ; a mine where gold ore, or alluvial gold is extracted
        case MNAU
        /// coal mine(s) ; a mine where coal is extracted
        case MNC
        /// chrome mine(s) ; a mine where chrome ore is extracted
        case MNCR
        /// copper mine(s) ; a mine where copper ore is extracted
        case MNCU
        /// iron mine(s) ; a mine where iron ore is extracted
        case MNFE
        /// monument ; a commemorative structure or statue
        case MNMT
        /// salt mine(s) ; a mine from which salt is extracted
        case MNN
        /// abandoned mine ;
        case MNQ
        /// quarry(-ies) ; a surface mine where building stone or gravel and sand, etc. are extracted
        case MNQR
        /// mole ; a massive structure of masonry or large stones serving as a pier or breakwater
        case MOLE
        /// mosque ; a building for public Islamic worship
        case MSQE
        /// mission ; a place characterized by dwellings, school, church, hospital and other facilities operated by a religious group for the purpose of providing charitable services and to propagate religion
        case MSSN
        /// abandoned mission ;
        case MSSNQ
        /// monastery ; a building and grounds where a community of monks lives in seclusion
        case MSTY
        /// metro station ; metro station (Underground, Tube, or Metro)
        case MTRO
        /// museum ; a building where objects of permanent interest in one or more of the arts and sciences are preserved and exhibited
        case MUS
        /// novitiate ; a religious house or school where novices are trained
        case NOV
        /// nursery(-ies) ; a place where plants are propagated for transplanting or grafting
        case NSY
        /// observation point ; a wildlife or scenic observation point
        case OBPT
        /// observatory ; a facility equipped for observation of atmospheric or space phenomena
        case OBS
        /// radio observatory ; a facility equipped with an array of antennae for receiving radio waves from space
        case OBSR
        /// oil pipeline junction ; a section of an oil pipeline where two or more pipes join together
        case OILJ
        /// abandoned oil well ;
        case OILQ
        /// oil refinery ; a facility for converting crude oil into refined petroleum products
        case OILR
        /// tank farm ; a tract of land occupied by large, cylindrical, metal tanks in which oil or liquid petrochemicals are stored
        case OILT
        /// oil well ; a well from which oil may be pumped
        case OILW
        /// opera house ; A theater designed chiefly for the performance of operas.
        case OPRA
        /// palace ; a large stately house, often a royal or presidential residence
        case PAL
        /// pagoda ; a tower-like storied structure, usually a Buddhist shrine
        case PGDA
        /// pier ; a structure built out into navigable water on piles providing berthing for ships and recreation
        case PIER
        /// parking lot ; an area used for parking vehicles
        case PKLT
        /// oil pumping station ; a facility for pumping oil through a pipeline
        case PMPO
        /// water pumping station ; a facility for pumping water from a major well or through a pipeline
        case PMPW
        /// post office ; a public building in which mail is received, sorted and distributed
        case PO
        /// police post ; a building in which police are stationed
        case PP
        /// abandoned police post ;
        case PPQ
        /// park gate ; a controlled access to a park
        case PRKGT
        /// park headquarters ; a park administrative facility
        case PRKHQ
        /// prison ; a facility for confining prisoners
        case PRN
        /// reformatory ; a facility for confining, training, and reforming young law offenders
        case PRNJ
        /// abandoned prison ;
        case PRNQ
        /// power station ; a facility for generating electric power
        case PS
        /// hydroelectric power station ; a building where electricity is generated from water power
        case PSH
        /// nuclear power station ; nuclear power station
        case PSN
        /// border post ; a post or station at an international boundary for the regulation of movement of people and goods
        case PSTB
        /// customs post ; a building at an international boundary where customs and duties are paid on goods
        case PSTC
        /// patrol post ; a post from which patrols are sent out
        case PSTP
        /// pyramid ; an ancient massive structure of square ground plan with four triangular faces meeting at a point and used for enclosing tombs
        case PYR
        /// pyramids ; ancient massive structures of square ground plan with four triangular faces meeting at a point and used for enclosing tombs
        case PYRS
        /// quay ; a structure of solid construction along a shore or bank which provides berthing for ships and which generally provides cargo handling facilities
        case QUAY
        /// traffic circle ; a road junction formed around a central circle about which traffic moves in one direction only
        case RDCR
        /// intersection ; a junction of two or more highways by a system of separate levels that permit traffic to pass from one to another without the crossing of traffic streams
        case RDIN
        /// golf course ; a recreation field where golf is played
        case RECG
        /// racetrack ; a track where races are held
        case RECR
        /// restaurant ; A place where meals are served to the public
        case REST
        /// store ; a building where goods and/or services are offered for sale
        case RET
        /// resthouse ; a structure maintained for the rest and shelter of travelers
        case RHSE
        /// rookery ; a breeding place of a colony of birds or seals
        case RKRY
        /// religious site ; an ancient site of significant religious importance
        case RLG
        /// retreat ; a place of temporary seclusion, especially for religious groups
        case RLGR
        /// ranch(es) ; a large farm specializing in extensive grazing of livestock
        case RNCH
        /// railroad siding ; a short track parallel to and joining the main track
        case RSD
        /// railroad signal ; a signal at the entrance of a particular section of track governing the movement of trains
        case RSGNL
        /// resort ; a specialized facility for vacation, health, or participation sports activities
        case RSRT
        /// railroad station ; a facility comprising ticket office, platforms, etc. for loading and unloading train passengers and freight
        case RSTN
        /// abandoned railroad station ;
        case RSTNQ
        /// railroad stop ; a place lacking station facilities where trains stop to pick up and unload passengers and freight
        case RSTP
        /// abandoned railroad stop ;
        case RSTPQ
        /// ruin(s) ; a destroyed or decayed structure which is no longer functional
        case RUIN
        /// school ; building(s) where instruction in one or more branches of knowledge takes place
        case SCH
        /// agricultural school ; a school with a curriculum focused on agriculture
        case SCHA
        /// college ; the grounds and buildings of an institution of higher learning
        case SCHC
        /// language school ; Language Schools & Institutions
        case SCHL
        /// military school ; a school at which military science forms the core of the curriculum
        case SCHM
        /// maritime school ; a school at which maritime sciences form the core of the curriculum
        case SCHN
        /// technical school ; post-secondary school with a specifically technical or vocational curriculum
        case SCHT
        /// State Exam Prep Centre ; state exam preparation centres
        case SECP
        /// sheepfold ; a fence or wall enclosure for sheep and other small herd animals
        case SHPF
        /// shrine ; a structure or place memorializing a person or religious concept
        case SHRN
        /// storehouse ; a building for storing goods, especially provisions
        case SHSE
        /// sluice ; a conduit or passage for carrying off surplus water from a waterbody, usually regulated by means of a sluice gate
        case SLCE
        /// sanatorium ; a facility where victims of physical or mental disorders are treated
        case SNTR
        /// spa ; a resort area usually developed around a medicinal spring
        case SPA
        /// spillway ; a passage or outlet through which surplus water flows over, around or through a dam
        case SPLY
        /// square ; a broad, open, public area near the center of a town or city
        case SQR
        /// stable ; a building for the shelter and feeding of farm animals, especially horses
        case STBL
        /// stadium ; a structure with an enclosure for athletic games with tiers of seats for spectators
        case STDM
        /// scientific research base ; a scientific facility used as a base from which research is carried out or monitored
        case STNB
        /// coast guard station ; a facility from which the coast is guarded by armed vessels
        case STNC
        /// experiment station ; a facility for carrying out experiments
        case STNE
        /// forest station ; a collection of buildings and facilities for carrying out forest management
        case STNF
        /// inspection station ; a station at which vehicles, goods, and people are inspected
        case STNI
        /// meteorological station ; a station at which weather elements are recorded
        case STNM
        /// radio station ; a facility for producing and transmitting information by radio waves
        case STNR
        /// satellite station ; a facility for tracking and communicating with orbiting satellites
        case STNS
        /// whaling station ; a facility for butchering whales and processing train oil
        case STNW
        /// steps ; stones or slabs placed for ease in ascending or descending a steep slope
        case STPS
        /// sewage treatment plant ; facility for the processing of sewage and/or wastewater
        case SWT
        /// synagogue ; a place for Jewish worship and religious instruction
        case SYG
        /// theater ; A building, room, or outdoor structure for the presentation of plays, films, or other dramatic performances
        case THTR
        /// tomb(s) ; a structure for interring bodies
        case TMB
        /// temple(s) ; an edifice dedicated to religious worship
        case TMPL
        /// cattle dipping tank ; a small artificial pond used for immersing cattle in chemically treated water for disease control
        case TNKD
        /// toll gate/barrier ; highway toll collection station
        case TOLL
        /// tower ; a high conspicuous structure, typically much higher than its diameter
        case TOWR
        /// tram ; rail vehicle along urban streets (also known as streetcar or trolley)
        case TRAM
        /// transit terminal ; facilities for the handling of vehicular freight and passengers
        case TRANT
        /// triangulation station ; a point on the earth whose position has been determined by triangulation
        case TRIG
        /// oil pipeline terminal ; a tank farm or loading facility at the end of an oil pipeline
        case TRMO
        /// temp work office ; Temporary Work Offices
        case TWO
        /// university prep school ; University Preparation Schools & Institutions
        case UNIP
        /// university ; An institution for higher learning with teaching and research facilities constituting a graduate school and professional schools that award master's degrees and doctorates and an undergraduate division that awards bachelor's
        /// degrees.
        case UNIV
        /// united states government establishment ; a facility operated by the United States Government in Panama
        case USGE
        /// veterinary facility ; a building or camp at which veterinary services are available
        case VETF
        /// wall ; a thick masonry structure, usually enclosing a field or building, or forming the side of a structure
        case WALL
        /// ancient wall ; the remains of a linear defensive stone structure
        case WALLA
        /// weir(s) ; a small dam in a stream, designed to raise the water level or to divert stream flow through a desired channel
        case WEIR
        /// wharf(-ves) ; a structure of open rather than solid construction along a shore or a bank which provides berthing for ships and cargo-handling facilities
        case WHRF
        /// wreck ; the site of the remains of a wrecked vessel
        case WRCK
        /// waterworks ; a facility for supplying potable water through a water source and a system of pumps and filtration beds
        case WTRW
        /// free trade zone ; an area, usually a section of a port, where goods may be received and shipped free of customs duty and of most customs regulations
        case ZNF
        /// zoo ; a zoological garden or park where wild animals are kept for exhibition
        case ZOO
        /// Class T  - mountain,hill,rock,...
        /// asphalt lake ; a small basin containing naturally occurring asphalt
        case ASPH
        /// atoll(s) ; a ring-shaped coral reef which has closely spaced islands on it encircling a lagoon
        case ATOL
        /// bar ; a shallow ridge or mound of coarse unconsolidated material in a stream channel, at the mouth of a stream, estuary, or lagoon and in the wave-break zone along coasts
        case BAR
        /// beach ; a shore zone of coarse unconsolidated sediment that extends from the low-water line to the highest reach of storm waves
        case BCH
        /// beaches ; a shore zone of coarse unconsolidated sediment that extends from the low-water line to the highest reach of storm waves
        case BCHS
        /// badlands ; an area characterized by a maze of very closely spaced, deep, narrow, steep-sided ravines, and sharp crests and pinnacles
        case BDLD
        /// boulder field ; a high altitude or high latitude bare, flat area covered with large angular rocks
        case BLDR
        /// blowhole(s) ; a hole in coastal rock through which sea water is forced by a rising tide or waves and spurted through an outlet into the air
        case BLHL
        /// blowout(s) ; a small depression in sandy terrain, caused by wind erosion
        case BLOW
        /// bench ; a long, narrow bedrock platform bounded by steeper slopes above and below, usually overlooking a waterbody
        case BNCH
        /// butte(s) ; a small, isolated, usually flat-topped hill with steep sides
        case BUTE
        /// cape ; a land area, more prominent than a point, projecting into the sea and marking a notable change in coastal direction
        case CAPE
        /// cleft(s) ; a deep narrow slot, notch, or groove in a coastal cliff
        case CFT
        /// caldera ; a depression measuring kilometers across formed by the collapse of a volcanic mountain
        case CLDA
        /// cliff(s) ; a high, steep to perpendicular slope overlooking a waterbody or lower area
        case CLF
        /// canyon ; a deep, narrow valley with steep sides cutting into a plateau or mountainous area
        case CNYN
        /// cone(s) ; a conical landform composed of mud or volcanic material
        case CONE
        /// corridor ; a strip or area of land having significance as an access way
        case CRDR
        /// cirque ; a bowl-like hollow partially surrounded by cliffs or steep slopes at the head of a glaciated valley
        case CRQ
        /// cirques ; bowl-like hollows partially surrounded by cliffs or steep slopes at the head of a glaciated valley
        case CRQS
        /// crater(s) ; a generally circular saucer or bowl-shaped depression caused by volcanic or meteorite explosive action
        case CRTR
        /// cuesta(s) ; an asymmetric ridge formed on tilted strata
        case CUET
        /// delta ; a flat plain formed by alluvial deposits at the mouth of a stream
        case DLTA
        /// depression(s) ; a low area surrounded by higher land and usually characterized by interior drainage
        case DPR
        /// desert ; a large area with little or no vegetation due to extreme environmental conditions
        case DSRT
        /// dune(s) ; a wave form, ridge or star shape feature composed of sand
        case DUNE
        /// divide ; a line separating adjacent drainage basins
        case DVD
        /// sandy desert ; an extensive tract of shifting sand and sand dunes
        case ERG
        /// fan(s) ; a fan-shaped wedge of coarse alluvium with apex merging with a mountain stream bed and the fan spreading out at a low angle slope onto an adjacent plain
        case FAN
        /// ford ; a shallow part of a stream which can be crossed on foot or by land vehicle
        case FORD
        /// fissure ; a crack associated with volcanism
        case FSR
        /// gap ; a low place in a ridge, not used for transportation
        case GAP
        /// gorge(s) ; a short, narrow, steep-sided section of a stream valley
        case GRGE
        /// headland ; a high projection of land extending into a large body of water beyond the line of the coast
        case HDLD
        /// hill ; a rounded elevation of limited extent rising above the surrounding land with local relief of less than 300m
        case HLL
        /// hills ; rounded elevations of limited extent rising above the surrounding land with local relief of less than 300m
        case HLLS
        /// hammock(s) ; a patch of ground, distinct from and slightly above the surrounding plain or wetland. Often occurs in groups
        case HMCK
        /// rock desert ; a relatively sand-free, high bedrock plateau in a hot desert, with or without a gravel veneer
        case HMDA
        /// interfluve ; a relatively undissected upland between adjacent stream valleys
        case INTF
        /// island ; a tract of land, smaller than a continent, surrounded by water at high water
        case ISL
        /// islet ; small island, bigger than rock, smaller than island.
        case ISLET
        /// artificial island ; an island created by landfill or diking and filling in a wetland, bay, or lagoon
        case ISLF
        /// mangrove island ; a mangrove swamp surrounded by a waterbody
        case ISLM
        /// islands ; tracts of land, smaller than a continent, surrounded by water at high water
        case ISLS
        /// land-tied island ; a coastal island connected to the mainland by barrier beaches, levees or dikes
        case ISLT
        /// section of island ;
        case ISLX
        /// isthmus ; a narrow strip of land connecting two larger land masses and bordered by water
        case ISTH
        /// karst area ; a distinctive landscape developed on soluble rock such as limestone characterized by sinkholes, caves, disappearing streams, and underground drainage
        case KRST
        /// lava area ; an area of solidified lava
        case LAVA
        /// levee ; a natural low embankment bordering a distributary or meandering stream; often built up artificially to control floods
        case LEV
        /// mesa(s) ; a flat-topped, isolated elevation with steep slopes on all sides, less extensive than a plateau
        case MESA
        /// mound(s) ; a low, isolated, rounded hill
        case MND
        /// moraine ; a mound, ridge, or other accumulation of glacial till
        case MRN
        /// mountain ; an elevation standing high above the surrounding area with small summit area, steep slopes and local relief of 300m or more
        case MT
        /// mountains ; a mountain range or a group of mountains or high ridges
        case MTS
        /// meander neck ; a narrow strip of land between the two limbs of a meander loop at its narrowest point
        case NKM
        /// nunatak ; a rock or mountain peak protruding through glacial ice
        case NTK
        /// nunataks ; rocks or mountain peaks protruding through glacial ice
        case NTKS
        /// pan ; a near-level shallow, natural depression or basin, usually containing an intermittent lake, pond, or pool
        case PAN
        /// pans ; a near-level shallow, natural depression or basin, usually containing an intermittent lake, pond, or pool
        case PANS
        /// pass ; a break in a mountain range or other high obstruction, used for transportation from one side to the other [See also gap]
        case PASS
        /// peninsula ; an elongate area of land projecting into a body of water and nearly surrounded by water
        case PEN
        /// section of peninsula ;
        case PENX
        /// peak ; a pointed elevation atop a mountain, ridge, or other hypsographic feature
        case PK
        /// peaks ; pointed elevations atop a mountain, ridge, or other hypsographic features
        case PKS
        /// plateau ; an elevated plain with steep slopes on one or more sides, and often with incised streams
        case PLAT
        /// section of plateau ;
        case PLATX
        /// polder ; an area reclaimed from the sea by diking and draining
        case PLDR
        /// plain(s) ; an extensive area of comparatively level to gently undulating land, lacking surface irregularities, and usually adjacent to a higher area
        case PLN
        /// section of plain ;
        case PLNX
        /// promontory(-ies) ; a bluff or prominent hill overlooking or projecting into a lowland
        case PROM
        /// point ; a tapering piece of land projecting into a body of water, less prominent than a cape
        case PT
        /// points ; tapering pieces of land projecting into a body of water, less prominent than a cape
        case PTS
        /// beach ridge ; a ridge of sand just inland and parallel to the beach, usually in series
        case RDGB
        /// ridge(s) ; a long narrow elevation with steep sides, and a more or less continuous crest
        case RDGE
        /// stony desert ; a desert plain characterized by a surface veneer of gravel and stones
        case REG
        /// rock ; a conspicuous, isolated rocky mass
        case RK
        /// rockfall ; an irregular mass of fallen rock at the base of a cliff or steep slope
        case RKFL
        /// rocks ; conspicuous, isolated rocky masses
        case RKS
        /// sand area ; a tract of land covered with sand
        case SAND
        /// dry stream bed ; a channel formerly containing the water of a stream
        case SBED
        /// escarpment ; a long line of cliffs or steep slopes separating level surfaces above and below
        case SCRP
        /// saddle ; a broad, open pass crossing a ridge or between hills or mountains
        case SDL
        /// shore ; a narrow zone bordering a waterbody which covers and uncovers at high and low water, respectively
        case SHOR
        /// sinkhole ; a small crater-shape depression in a karst area
        case SINK
        /// slide ; a mound of earth material, at the base of a slope and the associated scoured area
        case SLID
        /// slope(s) ; a surface with a relatively uniform slope angle
        case SLP
        /// spit ; a narrow, straight or curved continuation of a beach into a waterbody
        case SPIT
        /// spur(s) ; a subordinate ridge projecting outward from a hill, mountain or other elevation
        case SPUR
        /// talus slope ; a steep concave slope formed by an accumulation of loose rock fragments at the base of a cliff or steep slope
        case TAL
        /// interdune trough(s) ; a long wind-swept trough between parallel longitudinal dunes
        case TRGD
        /// terrace ; a long, narrow alluvial platform bounded by steeper slopes above and below, usually overlooking a waterbody
        case TRR
        /// upland ; an extensive interior region of high land with low to moderate surface relief
        case UPLD
        /// valley ; an elongated depression usually traversed by a stream
        case VAL
        /// hanging valley ; a valley the floor of which is notably higher than the valley or shore to which it leads; most common in areas that have been glaciated
        case VALG
        /// valleys ; elongated depressions usually traversed by a stream
        case VALS
        /// section of valley ;
        case VALX
        /// volcano ; a conical elevation composed of volcanic materials with a crater at the top
        case VLC
        /// Class U  - undersea
        /// apron ; a gentle slope, with a generally smooth surface, particularly found around groups of islands and seamounts
        case APNU
        /// arch ; a low bulge around the southeastern end of the island of Hawaii
        case ARCU
        /// arrugado ; an area of subdued corrugations off Baja California
        case ARRU
        /// borderland ; a region adjacent to a continent, normally occupied by or bordering a shelf, that is highly irregular with depths well in excess of those typical of a shelf
        case BDLU
        /// banks ; elevations, typically located on a shelf, over which the depth of water is relatively shallow but sufficient for safe surface navigation
        case BKSU
        /// bank ; an elevation, typically located on a shelf, over which the depth of water is relatively shallow but sufficient for safe surface navigation
        case BNKU
        /// basin ; a depression more or less equidimensional in plan and of variable extent
        case BSNU
        /// cordillera ; an entire mountain system including the subordinate ranges, interior plateaus, and basins
        case CDAU
        /// canyons ; relatively narrow, deep depressions with steep sides, the bottom of which generally has a continuous slope
        case CNSU
        /// canyon ; a relatively narrow, deep depression with steep sides, the bottom of which generally has a continuous slope
        case CNYU
        /// continental rise ; a gentle slope rising from oceanic depths towards the foot of a continental slope
        case CRSU
        /// deep ; a localized deep area within the confines of a larger feature, such as a trough, basin or trench
        case DEPU
        /// shelf edge ; a line along which there is a marked increase of slope at the outer margin of a continental shelf or island shelf
        case EDGU
        /// escarpment (or scarp) ; an elongated and comparatively steep slope separating flat or gently sloping areas
        case ESCU
        /// fan ; a relatively smooth feature normally sloping away from the lower termination of a canyon or canyon system
        case FANU
        /// flat ; a small level or nearly level area
        case FLTU
        /// fracture zone ; an extensive linear zone of irregular topography of the sea floor, characterized by steep-sided or asymmetrical ridges, troughs, or escarpments
        case FRZU
        /// furrow ; a closed, linear, narrow, shallow depression
        case FURU
        /// gap ; a narrow break in a ridge or rise
        case GAPU
        /// gully ; a small valley-like feature
        case GLYU
        /// hill ; an elevation rising generally less than 500 meters
        case HLLU
        /// hills ; elevations rising generally less than 500 meters
        case HLSU
        /// hole ; a small depression of the sea floor
        case HOLU
        /// knoll ; an elevation rising generally more than 500 meters and less than 1,000 meters and of limited extent across the summit
        case KNLU
        /// knolls ; elevations rising generally more than 500 meters and less than 1,000 meters and of limited extent across the summits
        case KNSU
        /// ledge ; a rocky projection or outcrop, commonly linear and near shore
        case LDGU
        /// levee ; an embankment bordering a canyon, valley, or seachannel
        case LEVU
        /// mesa ; an isolated, extensive, flat-topped elevation on the shelf, with relatively steep sides
        case MESU
        /// mound ; a low, isolated, rounded hill
        case MNDU
        /// moat ; an annular depression that may not be continuous, located at the base of many seamounts, islands, and other isolated elevations
        case MOTU
        /// mountain ; a well-delineated subdivision of a large and complex positive feature
        case MTU
        /// peaks ; prominent elevations, part of a larger feature, either pointed or of very limited extent across the summit
        case PKSU
        /// peak ; a prominent elevation, part of a larger feature, either pointed or of very limited extent across the summit
        case PKU
        /// plain ; a flat, gently sloping or nearly level region
        case PLNU
        /// plateau ; a comparatively flat-topped feature of considerable extent, dropping off abruptly on one or more sides
        case PLTU
        /// pinnacle ; a high tower or spire-shaped pillar of rock or coral, alone or cresting a summit
        case PNLU
        /// province ; a region identifiable by a group of similar physiographic features whose characteristics are markedly in contrast with surrounding areas
        case PRVU
        /// ridge ; a long narrow elevation with steep sides
        case RDGU
        /// ridges ; long narrow elevations with steep sides
        case RDSU
        /// reefs ; surface-navigation hazards composed of consolidated material
        case RFSU
        /// reef ; a surface-navigation hazard composed of consolidated material
        case RFU
        /// rise ; a broad elevation that rises gently, and generally smoothly, from the sea floor
        case RISU
        /// seachannel ; a continuously sloping, elongated depression commonly found in fans or plains and customarily bordered by levees on one or two sides
        case SCNU
        /// seachannels ; continuously sloping, elongated depressions commonly found in fans or plains and customarily bordered by levees on one or two sides
        case SCSU
        /// saddle ; a low part, resembling in shape a saddle, in a ridge or between contiguous seamounts
        case SDLU
        /// shelf ; a zone adjacent to a continent (or around an island) that extends from the low water line to a depth at which there is usually a marked increase of slope towards oceanic depths
        case SHFU
        /// shoal ; a surface-navigation hazard composed of unconsolidated material
        case SHLU
        /// shoals ; hazards to surface navigation composed of unconsolidated material
        case SHSU
        /// shelf valley ; a valley on the shelf, generally the shoreward extension of a canyon
        case SHVU
        /// sill ; the low part of a gap or saddle separating basins
        case SILU
        /// slope ; the slope seaward from the shelf edge to the beginning of a continental rise or the point where there is a general reduction in slope
        case SLPU
        /// seamounts ; elevations rising generally more than 1,000 meters and of limited extent across the summit
        case SMSU
        /// seamount ; an elevation rising generally more than 1,000 meters and of limited extent across the summit
        case SMU
        /// spur ; a subordinate elevation, ridge, or rise projecting outward from a larger feature
        case SPRU
        /// terrace ; a relatively flat horizontal or gently inclined surface, sometimes long and narrow, which is bounded by a steeper ascending slope on one side and by a steep descending slope on the opposite side
        case TERU
        /// tablemounts (or guyots) ; seamounts having a comparatively smooth, flat top
        case TMSU
        /// tablemount (or guyot) ; a seamount having a comparatively smooth, flat top
        case TMTU
        /// tongue ; an elongate (tongue-like) extension of a flat sea floor into an adjacent higher feature
        case TNGU
        /// trough ; a long depression of the sea floor characteristically flat bottomed and steep sided, and normally shallower than a trench
        case TRGU
        /// trench ; a long, narrow, characteristically very deep and asymmetrical depression of the sea floor, with relatively steep sides
        case TRNU
        /// valley ; a relatively shallow, wide depression, the bottom of which usually has a continuous gradient
        case VALU
        /// valleys ; a relatively shallow, wide depression, the bottom of which usually has a continuous gradient
        case VLSU
        /// Class V  - forest,heath,...
        /// bush(es) ; a small clump of conspicuous bushes in an otherwise bare area
        case BUSH
        /// cultivated area ; an area under cultivation
        case CULT
        /// forest(s) ; an area dominated by tree vegetation
        case FRST
        /// fossilized forest ; a forest fossilized by geologic processes and now exposed at the earth's surface
        case FRSTF
        /// grove ; a small wooded area or collection of trees growing closely together, occurring naturally or deliberately planted
        case GROVE
        /// grassland ; an area dominated by grass vegetation
        case GRSLD
        /// coconut grove ; a planting of coconut trees
        case GRVC
        /// olive grove ; a planting of olive trees
        case GRVO
        /// palm grove ; a planting of palm trees
        case GRVP
        /// pine grove ; a planting of pine trees
        case GRVPN
        /// heath ; an upland moor or sandy area dominated by low shrubby vegetation including heather
        case HTH
        /// meadow ; a small, poorly drained area dominated by grassy vegetation
        case MDW
        /// orchard(s) ; a planting of fruit or nut trees
        case OCH
        /// scrubland ; an area of low trees, bushes, and shrubs stunted by some environmental limitation
        case SCRB
        /// tree(s) ; a conspicuous tree used as a landmark
        case TREE
        /// tundra ; a marshy, treeless, high latitude plain, dominated by mosses, lichens, and low shrub vegetation under permafrost conditions
        case TUND
        /// vineyard ; a planting of grapevines
        case VIN
        /// vineyards ; plantings of grapevines
        case VINS
        /// not available ;
        case ll
    }
}

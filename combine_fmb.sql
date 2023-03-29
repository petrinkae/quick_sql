drop table if exists fmb_joined cascade;

CREATE TABLE fmb_joined AS (
    SELECT
	    fmb.folioid 
	    ,fmb.strap 
	    ,fmb.sitestreetnumber 
	    ,fmb.sitestreetname 
	    ,fmb.siteunit 
	    ,fmb.sitecity 
	    ,fmb.sitezip 
	    ,fmb.ownername 
	    ,fmb.others 
	    ,fmb.careof 
	    ,fmb.owneraddress1 
	    ,fmb.owneraddress2 
	    ,fmb.ownercity 
	    ,fmb.ownerstate 
	    ,fmb.ownerzip 
	    ,fmb.ownercountry 
	    ,fmb.improvementcode 
	    ,fmb.improvementdescription 
	    ,fmb.dorcode 
	    ,fmb.dordescription 
	    ,fmb.justvalue 
	    ,fmb.landvalue 
	    ,fmb.buildingvalue 
	    ,fmb.heatedarea 
	    ,fmb.bathrooms 
	    ,fmb.yearbuilt 
	    ,fmb.pool 
	    ,fmb.ornumber 
	    ,fmb.saledate 
	    ,fmb.saleamount 
	    ,fmb.grossarea 
	    ,fmb.totallivingarea 
	    ,fmb.landarea 
	    ,fmb.landcode 
	    ,fmb.landdescription 
	    ,fmb.legaldescription
        ,hurricane.pkey 
        ,hurricane.keynumber 
        ,hurricane.eventkeynumber 
        ,hurricane.event 
        ,hurricane.eventtype 
        ,hurricane.eventdate 
        ,hurricane.reporttype 
        ,hurricane.repairstatus 
        ,hurricane.description 
        ,hurricane.repaired 
        ,hurricane.repairstatusdate 
        ,hurricane.comments 
        ,hurricane.buildingno 
        ,hurricane.buildingkey 
        ,hurricane.totaldamagepct 
        ,hurricane.damagecategory 
        ,hurricane.structurevalue 
        ,hurricane.damageamount 
        ,hurricane.adjustmentamount 
        ,hurricane.adjustmenttype 
        ,hurricane.marketvalue 
        ,hurricane.milestone 
        ,hurricane.buildingdamage 
        ,hurricane.subareadamage 
        ,hurricane.xfeaturedamage 
        ,hurricane.iscalamity 
        ,hurricane.maintdate 
        ,hurricane.maintuser 
        ,hurricane.createddate 
        ,hurricane.createduser 
        ,hurricane.roofdamage 
        ,hurricane.extwalldamage 
        ,hurricane.intwalldamage 
        ,hurricane.floordamage 
        ,hurricane.foundationdamage 
        ,hurricane.plumbingdamage 
        ,hurricane.electricdamage 
        ,hurricane.acdamage 
        ,hurricane.poweroff 
        ,hurricane.uninhabitable 
        ,hurricane.waterpresent 
        ,hurricane.confidential 
        ,hurricane.streetnumber 
        ,hurricane.streetname 
        ,hurricane.unit 
        ,hurricane.city 
        ,hurricane.zip 
        ,hurricane.searchaddress 
        ,hurricane.latitude 
        ,hurricane.longitude 
        ,hurricane.municode 
        ,hurricane.dorcode AS h_dorcode
        ,hurricane.dordescription AS h_dordescription
        ,hurricane.dortype AS h_dortype
    	,building.objectid  
        ,building.created_user  
        ,building.created_date  
        ,building.last_edited_user  
        ,building.last_edited_date  
        ,building.shape  
        ,building.type
    from fmb

    LEFT JOIN hurricane
    on fmb.folioid = hurricane.folioid

    LEFT JOIN building
    on building.folioid = fmb.folioid

);

\copy (select * from fmb_joined) to 'output/fmb_joined.csv' csv header;
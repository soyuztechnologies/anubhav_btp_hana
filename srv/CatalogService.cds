using { anubhav } from '../db/datamodel';

using CV_BP from '../db/datamodel';
using CV_PURCHASE from '../db/datamodel';

service CatalogService{

entity BusinessPartner as projection on anubhav.db.master.businesspartner;

function sleep() returns Boolean;

@readonly
entity CV_bp as projection on CV_BP;
@readonly
entity CV_Purchase as projection on CV_PURCHASE;
}

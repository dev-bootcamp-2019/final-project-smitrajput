const routes = require('next-routes')();

routes
		.add('/bounty-creator/new', '/NewBountyCreator')
		.add('/bounty-creator/:address', '/BountyCreator')
		// .add('/campaigns/:address/requests', '/campaigns/requests/index')
		// .add('/campaigns/:address/requests/new','/campaigns/requests/new');
		
module.exports = routes;
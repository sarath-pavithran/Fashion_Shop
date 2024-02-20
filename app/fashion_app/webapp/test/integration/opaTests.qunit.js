sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'fashionapp/test/integration/FirstJourney',
		'fashionapp/test/integration/pages/SectionsList',
		'fashionapp/test/integration/pages/SectionsObjectPage'
    ],
    function(JourneyRunner, opaJourney, SectionsList, SectionsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('fashionapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSectionsList: SectionsList,
					onTheSectionsObjectPage: SectionsObjectPage
                }
            },
            opaJourney.run
        );
    }
);
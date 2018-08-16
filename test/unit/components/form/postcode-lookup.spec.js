const testHelper = require('../../../helpers/test-helper');

describe('Postcode lookup form dust component', function() {
  testHelper.setupBefore()

  it('should return html from the dust component', function(done) {
    testHelper.shunterTest('postcode-lookup', 'components__form__postcode-lookup', 'components/form', done)
  });
});

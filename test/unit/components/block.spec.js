const testHelper = require('../../helpers/test-helper');

describe('Block dust component', function() {
  testHelper.setupBefore()

  it('should return html from the dust component', function(done) {
    testHelper.shunterTest('block', 'components__block', 'components', done)
  });
});

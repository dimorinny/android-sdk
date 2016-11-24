import pytest
from hamcrest import assert_that, is_


# noinspection PyPep8Naming
@pytest.mark.usefixtures("TestinfraBackend")
@pytest.mark.dockerfile()
class TestEnvironment(object):
    def test_gcloud_exists(self, Command):
        assert_that(Command('gcloud').rc, is_(0))

    def test_gsutil_exists(self, Command):
        assert_that(Command('gsutil').rc, is_(0))

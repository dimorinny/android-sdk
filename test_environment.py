import pytest
from hamcrest import assert_that, is_, contains_string

# noinspection PyPep8Naming
@pytest.mark.usefixtures("TestinfraBackend")
@pytest.mark.dockerfile()
class TestEnvironment(object):
    def test_gcloud_exists(self, Command):
        assert_that(Command('gcloud -v').rc, is_(0))

    def test_gsutil_exists(self, Command):
        assert_that(Command('gsutil -v').rc, is_(0))

    def test_gsutil_with_crc_enabled(self, Command):
        assert_that(Command('gsutil version -l').stdout,contains_string('compiled crcmod: True'))

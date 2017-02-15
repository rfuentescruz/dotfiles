# Environment
DIST := $(shell lsb_release --codename --short)
USER := $(shell whoami)

# Commands
PUPPET_BIN_DIR := /opt/puppetlabs/puppet/bin
GEM    := $(PUPPET_BIN_DIR)/gem
PUPPET := $(PUPPET_BIN_DIR)/puppet
R10K   := $(PUPPET_BIN_DIR)/r10k
LIBRARIAN := $(PUPPET_BIN_DIR)/librarian-puppet

.PHONY: all
all: librarian puppet

.PHONY: clean
clean:
	rm --force --recursive ext_modules/
	rm --force --recursive modules/

.PHONY: install
install: $(PUPPET)

.PHONY: puppet
puppet: | $(PUPPET)
	sudo \
	    FACTER_dbus_session_bus_address=$(DBUS_SESSION_BUS_ADDRESS) \
	    FACTER_id=$(USER) \
	    $(PUPPET) apply \
		--basemodulepath=./modules:./ext_modules \
		--hiera_config=./hiera.yaml \
		--strict_variables \
		./manifests/site.pp

.PHONY: r10k
r10k: ext_modules

.PHONY: libriarian
librarian: modules
#===============================================================================

$(PUPPET_BIN_DIR)/%:
	wget --config=/dev/null --no-verbose --output-document=/tmp/puppet.deb https://apt.puppetlabs.com/puppetlabs-release-pc1-$(DIST).deb
	sudo dpkg --install /tmp/puppet.deb
	sudo apt-get --quiet update
	sudo DEBIAN_FRONTEND=noninteractive apt-get --quiet --yes install puppet-agent
	sudo ln -s $(PUPPET) /usr/local/bin/puppet

$(R10K): | $(GEM)
	sudo $(GEM) install \
	    --quiet \
	    --no-document \
	    --bindir /opt/puppetlabs/puppet/bin \
	    --install-dir /opt/puppetlabs/puppet/lib/ruby/gems/2.1.0 \
	    r10k

$(LIBRARIAN): | $(GEM)
	sudo $(GEM) install \
	    --quiet \
	    --no-document \
	    --bindir /opt/puppetlabs/puppet/bin \
	    --install-dir /opt/puppetlabs/puppet/lib/ruby/gems/2.1.0 \
	    librarian-puppet

ext_modules: Puppetfile | $(R10K)
	$(R10K) puppetfile install --verbose
	$(R10K) puppetfile purge

modules: Puppetfile | $(LIBRARIAN)
	$(LIBRARIAN) install --verbose

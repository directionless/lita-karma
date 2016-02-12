# -*- coding: utf-8 -*-
require "spec_helper"

describe Lita::Handlers::Karma::Chat, lita_handler: true do
  let(:payload) { double("payload") }

  prepend_before do
    unless registry.handlers.include?(Lita::Handlers::Karma::Config)
      registry.register_handler(Lita::Handlers::Karma::Config)
    end
  end

  before do
    registry.config.handlers.karma.cooldown = nil
    registry.config.handlers.karma.link_karma_threshold = nil
    described_class.routes.clear
    subject.define_routes(payload)
  end

  describe "#increment" do
    it "I should only have one increment route" do
      #bindings.pry
      matching_routes = described_class.routes.select {|r| r.callback.inspect.match(/increment/) }
      expect(matching_routes.length).to eq(1)
    end

    it "increases the term's score by one and says the new score" do
      send_message("ffoo++")
      expect(replies.last).to eq("ffoo: 1")
    end
  end


end


describe Cayley::Path do
  let(:graph) { spy(:graph) }
  let(:path) { described_class.vertex(graph) }
  let(:morphism_path) { described_class.morphism(graph) }

  context '#construct' do
    it 'should be ok' do
      expect(path.construct).to eq 'graph.Vertex()'
    end

    it 'should be ok' do
      expect(path.has('something').construct).to eq 'graph.Vertex().Has("something")'
    end

    it 'should be ok' do
      expect(path.in('something').construct).to eq 'graph.Vertex().In("something")'
    end
  end

  context '#follow' do
    it 'should be ok' do
      p1 = path.has('something')
      p2 = morphism_path.out('other_thing')
      p = p1.follow(p2)

      expect(p.calls).to eq p1.calls + p2.calls
      expect(p.construct).to eq 'graph.Vertex().Has("something").Out("other_thing")'
    end
  end

  context '#copy' do
    it 'should create duplicate' do
      p = path.copy
      expect(p.calls).to eq path.calls
      expect(p.object_id).not_to eq path.object_id
    end
  end

  context '#perform' do
    it 'should call graphs method' do
      path.perform
      expect(graph).to have_received(:perform).with(path)
    end
  end
end

var LinkForm = React.createClass({

  createLink(event) {
    event.preventDefault();
    var link = { 
      target_url: this.refs.target_url.value 
    }
    this.props.addLink(link);
  },

  render: function() {
    return(
      <form onSubmit={this.createLink}>
        <fieldset className="form-group">
          <label for="target_url">Enter URL</label>
          <input 
            type="text"
            id="target_url" 
            className="form-control"
            ref="target_url" 
            required
          />
          <small className="text-muted">URL must be valid</small>
        </fieldset>
        <button className="btn btn-primary" type="submit">Submit</button>
      </form>
    );
  } 
});

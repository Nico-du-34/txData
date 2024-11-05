// Import the necessary dependencies for testing
const $ = require('jquery');

// Import the function to be tested
const { showPreviewPage } = require('./functions');

// Mock the necessary dependencies
jest.mock('jquery');

describe('showPreviewPage', () => {
  beforeEach(() => {
    // Reset the mocked jQuery functions before each test
    $.post.mockReset();
    $.fn.html.mockReset();
    $.fn.find.mockReset();
    $.fn.click.mockReset();
  });

  test('should show the preview page with correct vehicle data', async () => {
    // Mock the vehicle data
    const vehicleData = {
      id: 'vehicle123',
      label: 'Car',
      price: 10000
    };

    // Mock the expected HTML elements
    const expectedHTML = `
      <div class="header">
        <!-- ... -->
      </div>
      <ul class="left-side-wrap vehicle-preview">
        <!-- ... -->
      </ul>
      <div class="rotate-vehicle vehicle-preview p-5">
        <!-- ... -->
      </div>
    `;

    // Mock the jQuery functions
    $.post.mockImplementationOnce(() => {});
    $.fn.html.mockImplementationOnce(function () {
      return this;
    });
    $.fn.find.mockImplementationOnce(function () {
      return this;
    });
    $.fn.click.mockImplementationOnce(function () {
      return this;
    });

    // Call the function to be tested
    await showPreviewPage(vehicleData);

    // Verify the jQuery functions were called with the correct arguments
    expect($.post).toHaveBeenCalledWith(`https://${resName}/showCarInShowroom`, JSON.stringify({ model: vehicleData.id }));
    expect($.fn.html).toHaveBeenCalledWith(expectedHTML);
    expect($.fn.find).toHaveBeenCalledTimes(4);
    expect($.fn.click).toHaveBeenCalledTimes(4);
  });

  // Add more test cases for different scenarios

});